Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUHFJ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUHFJ5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 05:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268112AbUHFJ5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 05:57:39 -0400
Received: from raven.ecs.soton.ac.uk ([152.78.70.1]:65011 "EHLO
	raven.ecs.soton.ac.uk") by vger.kernel.org with ESMTP
	id S268107AbUHFJ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 05:57:36 -0400
Message-ID: <411355B9.9060304@ecs.soton.ac.uk>
Date: Fri, 06 Aug 2004 10:56:09 +0100
From: kwl02r <kwl02r@ecs.soton.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange new system call problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact helpdesk@ecs.soton.ac.uk for more information
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hiya,

    I am running the Redhat9 with kernel-2.4.20-8. I added four new 
system calls for my application program.
    At file /asm/unistd.h, I added my system calls definition as following.
   
    #define __NR_set_tid_address    258 /* last system call defined by 
system*/

   #define __NR_mysystemcall1  259  /* my first system call*/
   #define __NR_mysystemcall2  260  /* my second system call*/
   #define __NR_mysystemcall3  261  /* my third system call*/
   #define __NR_mysystemcall4  262  /* my forth system call*/

   After this , I changed the linux/arch/i386/entry.S as following.
  . long SYMBOL_NAME(sys_mysystemcall1)             /* 259 system call */
  .long SYMBOL_NAME(sys_mysystemcall2)              /* 260 system call */
  .long SYMBOL_NAME(sys_mysystemcall3)              /* 261 system call */
  .long SYMBOL_NAME(sys_mysystemcall4)              /* 262 system call */

   When I compilered a new kernel, there was no any error messages.
   But only the new system call 259 was working. The rest of three 
(260-262) did not response
   anything. If I changed the position of system calls (259->260 and 
260->259), still the 259 had
   response. Anyway, only the new system call at the 259 position was 
working. What is wrong?
   Other questions are:
   (1) Is it correct that I add my new definitions at 
/linux/asm/unistd.h? There is another file under
         /linux/asm-i386/unistd.h
   (2) At entry.S, do I need to change codes following for my new system 
calls? How to change ?
       
       .rept NR_syscalls-(.-sys_call_table)/4
               .long SYMBOL_NAME(sys_ni_syscall)
        .endr

Thanks



   


 

   

