Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbSJWA35>; Tue, 22 Oct 2002 20:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSJWA35>; Tue, 22 Oct 2002 20:29:57 -0400
Received: from 80-195-6-171.cable.ubr04.ed.blueyonder.co.uk ([80.195.6.171]:25991
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262161AbSJWA34>; Tue, 22 Oct 2002 20:29:56 -0400
Date: Wed, 23 Oct 2002 01:35:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021023013551.A23214@redhat.com>
References: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu> <200210180014.16512.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210180014.16512.russell@coker.com.au>; from russell@coker.com.au on Fri, Oct 18, 2002 at 12:14:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 18, 2002 at 12:14:16AM +0200, Russell Coker wrote:
 
> OK, how do you go about supplying extra data to a file open than to modify the 
> open system call?
> 
> If for example I want to create a file of context 
> "system_u:object_r:fingerd_log_t" under /var/log (instead of taking the 
> context from that of the /var/log directory "system_u:object_r:var_log_t") 
> then how would I go about doing it other than through a modified open system 
> call?

With a "setesid(2)" syscall to set the effective sid.  

A new file already inherits a ton of context, from the current uid/gid
to the umask.  Those are already selectable by setting up the current
process context.  And for the uid/gid bits, we also have setfsuid to
set the id for creation without causing the whole process to suddenly
change ownership.

A similar way of setting the effective sid for new object creation
would eliminate over 20 of the new sys_security syscalls in the
SELinux patches.

--Stephen
