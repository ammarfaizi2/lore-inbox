Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUIPVYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUIPVYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUIPVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:24:12 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:32669
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S266561AbUIPVXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:23:49 -0400
Message-ID: <414A04F6.8040106@pbl.ca>
Date: Thu, 16 Sep 2004 16:26:14 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: argv null terminated in main()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking for info on this question on web and in documentation, but 
couldn't find it documented anywhere.

The question is, after call to execve() system call, and after new image 
is loaded, is argv (as passed to main() function of new program) NULL 
terminated or not in Linux?

So far I found article from Ritchie saying that argv[argc] was -1 up to 
Unix Sixth Edition (1975), and than it was changed to NULL starting from 
Seventh Edition (in 1979) and than later same behaviour was carried over 
to 32V and BSD.  Looking at the man page for exec(2) on Solaris, which 
is System V derivate, the documentation still states the same 
(argv[argc] is guaranteed to be NULL).

But how about Linux kernel?  What (if anything) is copied or filled into 
argv[argc] by execve()?

Documentation for execve() on Linux doesn't state it explicitly, but one 
could find himself lured into beleiving that argv[argc] should be NULL. 
  It says "The argument vector and environment can be accessed by the 
called program's main function, when it  is  defined as int main(int 
argc, char *argv[], char *envp[])".  Because original vector as passed 
to execve was NULL terminated.

I've looked in the kernel source code (just a glance), and by looking at 
copy_strings function in exec.c, it seems as argv[argc] might be 
undefined (it seems that loop copies only first argc - 1 elements of 
argv).  But I might be wrong.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
