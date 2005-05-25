Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVEYPBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVEYPBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVEYPBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:01:06 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:47853 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262351AbVEYPAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:00:32 -0400
Date: Wed, 25 May 2005 11:00:09 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505251046450.696@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek <pavel@ucw.cz> wrote on 05/24/2005 06:41:44 PM:

> 
> Maybe I'm just wrong... I definitely chosen bad example (grub) because
> it is also bootloader...
> 
> > (iv) From then on, the IMA in the kernel is responsible for measuring 
> > executables/modules before loading them and for maintaining the 
> > measurement list and its TPM aggregate. 
> 
> Kernel does not know what is exacutable and what is data. Thanks to
> buffer overflows, the line between executable and data is extremely
> blury.
> 
> Now, to my argumentation. Imagine bootscripts containing
> "show_etc_issue" command. (That shows /etc/issue). If there's buffer
> overflow in "show_etc_issue" command, it is *not* security issue as of
> now, because it only works on data provided by root. But it becomes
> issue when IMA system is in use, because now /etc/issue can be used to
> inject code into system; something that was not possible before.
> 
> OTOH buffer overrun in show_etc_issue is certainly bad thing, because
> it is unexpected behaviour; and if IMA means such stuff is fixed...
> 
> It just seems like a lot of work. You are basically adding check at
> every place where user can
>  shoot_himself_in_the_foot^W^W^W^W^Wdo_something_stupid_to_system_security
> . I suspect many config files can be used to compromise system
> security...
> 
>                         Pavel
> 

Pavel, I cannot follow your argumentation. Could you please expand on how
measuring a script file would affect existing buffer overflows at all?

Just to make sure we are in sync how user space measurements work, here
a summary at the bash example:

(i) bash at point x opens "show_etc_issue" and holds file descriptor in 
    fd_show

(ii) before bash reads the commands from fd_show, we insert a line of code
    writing fd_show down into the kernel (this is a fixed size data 
    structure)

(iii) IMA hook in the kernel now reads the whole file building a SHA1
      (there is no interpretation of any content of any file here)

(iv)  IMA decides whether the measurement of the file must be stored or 
      whether it is already in the measurement list etc.

(v)   writing fd_show returns to bash

(vi) bash reads the commands and executes them

If I understand you, then you are claiming that steps (ii) to (v) 
introduce buffer overflows in bash or show_etc_issue. How?

Thanks
Reiner

