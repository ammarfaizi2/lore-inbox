Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWGLAQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWGLAQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGLAQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:16:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12565 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932288AbWGLAQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:16:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EgWv2gOou5reId6Ar7xruwCIr9+h+iAaaC1Znq+9bKFqsDtQFRdA6gFp6rP5dWCVVFbK3xtaKgL//xLWcdYN7/AYZlfJBmfNqE+iPiZLz8Rcn5ezxK2s2UKihhIZjVZfE8OyrK3ueOuGmbBY7U/gHHk9wONy5FynKgrXlnmQ6UQ=
Message-ID: <a36005b50607111716t4756828dsafd740bfb90e6655@mail.gmail.com>
Date: Tue, 11 Jul 2006 17:16:46 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <44B41EC0.70404@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711075051.382004000@localhost.localdomain>
	 <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>
	 <44B3EDBA.4090109@zytor.com>
	 <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com>
	 <44B41D39.801@fr.ibm.com> <44B41EC0.70404@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, H. Peter Anvin <hpa@zytor.com> wrote:
> > #define EXECVEF_NEWNS 0x00000100
> > #define EXECVEF_NEWIPC        0x00000200
> > #define EXECVEF_NEWUTS        0x00000400
> > #define EXECVEF_NEWUSER       0x00000800

Yes on these.


> If flags comes first, I would rather like to call it execfve(), or
> perhaps execxve() ("extended") or execove() ("options").  execfve()
> sounds like it executes a file descriptor (which would probably be
> called fexecve()).

I think execfve is fine.


> Perhaps more seriously, if we're adding more functionality already, it
> should acquire -at functionality (execveat) and take a directory argument.

We have fexecve already.  Adding -at variants is probably not the best
idea, it's confusing.  Note, that fexecve only takes a file
descriptor, not a file descriptor plus file name.

The only reason I could see for changing this is thatfexecve depends
on /proc.  But there is so much other functionality which won't work
if /proc isn't mounted that I'd rank this low.  I'm fine with just
adding execfve.
