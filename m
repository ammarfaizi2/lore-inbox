Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031253AbWI0Xiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031253AbWI0Xiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031254AbWI0Xiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:38:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:25627 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031253AbWI0Xiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:38:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KXT70fWGD8iksVANTTqzHUxYXmR9T6LUQJMMUIDGKG6Zmac5sRdtg4b63SxX8TbOpxjo4ZaZ7dFhtyJmwnFWeym/BZx93ORTfciKn69CymzKHjAsXXfouOymU61II1EhOfdpLzuqsjXzSocdAMtCMmlRgVxutyPISNMtYpUVkrE=
Message-ID: <9a8748490609271638q590f10c3o8fb7d5e478e4dec2@mail.gmail.com>
Date: Thu, 28 Sep 2006 01:38:49 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <eff0dv$poj$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45150CD7.4010708@aknet.ru> <4516B721.5070801@redhat.com>
	 <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org>
	 <eff0dv$poj$1@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/06, David Wagner <daw@cs.berkeley.edu> wrote:
> Arjan van de Ven  wrote:
> >but really again you are degrading what noexec means.
>
> As far as I can tell, noexec never really did mean anything particularly
> coherent in the first place, so I find it hard to get upset about any
> potential degradation.
>
> (Second, as far as I can tell, it sounds like it may be more accurate
> to characterize this as "revert some of it back to the way the semantics
> were a year ago" than as "degrade noexec".  But even if it is a degradation,
> I fail to see why that is a problem.)
>
> Have you read my other email?  I notice that things got awfully quiet
> on this thread once I started asking some pointed questions about what
> exactly noexec is trying to solve and what exactly the threat model is.
> I'm still waiting to hear any answers to those questions or any dispute
> to my characterization of noexec.

Below are some examples of how I've used noexec in the past and found it useful.
Please not that I'm well aware that it can be circumvented via ld.so,
interpreters etc, so it's not a complete solution and not 100% secure,
I'm not trying to say it is.  Still, it has its uses.

1) Providing home directories for users that are mounted noexec
prevents the situation where a user downloads a malicious program and
accidentally executes it (for example by clicking on it in his GUI
filemanager by mistake).  With the dir mounted noexec the application
fails to run and the user (and admin) is spared some grief and
possibly backup restores.

2) serving static web pages from a filesystem mounted noexec offers a
bit of protection against script kiddies who have found a hole in my
webserver allowing them to exec a program from the web filesystem. It
won't protect against clever attackers who have found a security hole
big enough to allow them to work around noexec, but it does protect
against lot of script kiddies who just found some "hackme.exe" that
tries to just execute a few things (which I believe are the vast
majority).

3) I've often used noexec on filesystems used to store backup data,
simply to guard against my own mistakes. Working with many shells on
many boxes you sometimes make mistakes about what box you are on and
if the backup box holds a complete copy of a filesystem hierarchy
similar to the box you think you are on you may try executing some app
on the backup box - possibly with the bad result of modifying your
backup data. I know I've made that mistake in the past, but having the
backup fs noexec prevented the programs to run and saved me some
trouble.


All of the above could be solved more completely with SELinux, but
that's a lot more complicated than just using noexec, and in
situations where I just want to guard against mistakes or cassual
abuse (and where I have backups just in case someone does circumvent
it), noexec is often a lot easier and good enough - certainly far
better than nothing.
As long as you are aware of the limitations of the security you are
implementing and you accept the risks that limited security implies,
then sometimes weak security that you actually manage to implement is
a lot better than perfect security that you never get around to
implementing.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
