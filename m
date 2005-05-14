Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVENLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVENLtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVENLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:49:39 -0400
Received: from mail.shareable.org ([81.29.64.88]:15830 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262744AbVENLtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:49:35 -0400
Date: Sat, 14 May 2005 12:49:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bulb@ucw.cz, ericvh@gmail.com,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050514114915.GA19703@mail.shareable.org>
References: <E1DWVby-0000zz-00@dorka.pomaz.szeredi.hu> <OF61E069CA.D46E38EE-ON88257000.00738E9B-88257000.007F4E51@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF61E069CA.D46E38EE-ON88257000.00738E9B-88257000.007F4E51@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
> 2) after the private mount, don't let a program that has gained privileges 
> via set-uid see the user-made names.
> 
> My point is still that (2) can't be done because you can't know that a 
> program has gained privileged via set-uid.
> 
> If it's really not about set-uid, but about ptrace-like privilege 
> borrowing, please enlighten me.

Note that not all setuid programs gain *capabilities*.

You appear to be talking about setuid-root, but there is also
setuid-some-other-user, where the capabilities don't change but the
priveleges switch to those of another uid.

The right thing to do in that case is tricky.  For example, suppose
you have a program that's setuid to the "printer" user, which can copy
the caller's file to the printer queue directories in
/var/spool/printer.  Ideally, that program should be able to read the
calling user's file, looking up the path in the calling user's
namespace (that's important, because the path is provided by the
calling user), and then write to /var/spool/printer.  (*Really*
ideally /var/spool/printer wouldn't be visible in the calling user's
namespace, but that sort of design is straying far indeed from a unix
model).

-- Jamie
