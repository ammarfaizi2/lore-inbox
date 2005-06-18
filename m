Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVFRN5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVFRN5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVFRN5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:57:43 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:47803 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262117AbVFRN5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:57:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=IauCdZtsT5VgP9htuQUf1Nf8FTKQpEGLLYuYm7BtlhZPpg3ooablPqyPPF+AeonAr5daD0A7uMmYPmSimlx/PisfRJI8Bk+unUb6o0Rwcnw5rSp2kLNctqO/LbGDFpLa4COhnHqupkYmfAuvPnOXN/1+pdy1SvzobJbJ3SqiKWU=
Message-ID: <42B42907.8060404@gmail.com>
Date: Sat, 18 Jun 2005 22:00:39 +0800
From: Roy Lee <roylee17@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: zh-tw, en-us, en, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Could someone tell me more about the asmlinkage
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Why is there a asmlinkage before a syscall?"

I know this is a FAQ already, but I couldn't find an answer that clear enough 
for me to understand after "gooling" for some time. I've also read the FAQ of 
kernelnewbies.

The following is quoted from the FAQ of kernelnewbies.
-------
The asmlinkage tag is one other thing that we should observe about this simple 
function. This is a #define for some gcc magic that tells the compiler that the 
function should not expect to find any of its arguments in registers (a common 
optimization), but only on the CPU's stack. Recall our earlier assertion that 
system_call consumes its first argument, the system call number, and allows up 
to four more arguments that are passed along to the real system call. system_call 
achieves this feat simply by leaving its other arguments (which were passed to it 
in registers) on the stack. All system calls are marked with the asmlinkage tag, 
so they all look to the stack for arguments. Of course, in sys_ni_syscall's case, 
this doesn't make any difference, because sys_ni_syscall doesn't take any arguments, 
but it's an issue for most other system calls. And, because you'll be seeing asmlinkage 
in front of many other functions, I thought you should know what it was about.
--------

It says that "To tell a compiler not to use the argument in the registers". but the 
syscall's argument does pass the arguments though registers, doesn't it?

While tracing the code, I found the asmlinkage was a #define of a extern "C", and 
the only usage of extern "C" that I know is to avoid the name mangling while calling 
a C function in C++. Does the asmlinkage here have connection with that?

Roy



