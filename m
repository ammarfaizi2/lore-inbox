Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVA3Ksv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVA3Ksv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVA3Ksv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:48:51 -0500
Received: from 80.178.38.121.forward.012.net.il ([80.178.38.121]:20707 "EHLO
	linux15") by vger.kernel.org with ESMTP id S261669AbVA3Ksu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:48:50 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: Miles Sabin <miles@milessabin.com>
Subject: Re: Pipes and fd question. Large amounts of data.
Date: Sun, 30 Jan 2005 12:48:45 +0200
User-Agent: KMail/1.7.1
References: <200501301115.59532.ods15@ods15.dyndns.org> <200501300941.45554.miles@milessabin.com>
In-Reply-To: <200501300941.45554.miles@milessabin.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301248.45538.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 11:41, Miles wrote:
> My suggestion would be to perform blocking writes in a seperate thread
> for each of the two written-to fds. You can still use select/poll for
> the read side ... tho' once you're using threading on the write side it
> might be more straightforward to to use threading on the read side as
> well. Bear in mind that if you do that you'll need to dedicate threads
> to _each_ of the four fds, because each of them could block
> independently while progress is required on one or more of the others.
>
> I'd say that this was one of the rare cases where a solution using
> threads is not only superior to one using event-driven IO, but actually
> required.

Yeah, I reached just about the same conclusion. At first I thought only 2 
threads were necessary, one for each data flow, but I realized a deadlock 
could happen just as well in that too. Making a 4 thread implementation I 
trust is gonna be hard... I better get working. :)

Thanks for the reply,
- ods15
