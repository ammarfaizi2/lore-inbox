Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277219AbRJDUkU>; Thu, 4 Oct 2001 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277215AbRJDUkL>; Thu, 4 Oct 2001 16:40:11 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:5907 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S277220AbRJDUj6> convert rfc822-to-8bit; Thu, 4 Oct 2001 16:39:58 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: "Mattias =?iso-8859-1?Q?Engdeg=E5rd?=" <f91-men@nada.kth.se>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races 
In-Reply-To: Your message of "Thu, 04 Oct 2001 16:18:20 +0200."
             <200110041418.QAA17395@my.nada.kth.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 04 Oct 2001 13:39:36 -0700
Message-Id: <E15pFHM-0002H1-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't think it's contrived --- writing not a byte, but the pid and
>return status of the dead child to a pipe is an old but useful trick.
>It gives a natural serialisation of child deaths, and also eliminates
>the common race where a child dies before its parent has recorded its
>pid in a data structure. See it as a safe way of converting an
>asynchronous signal to a queued event.

Except that this enhancement is not completely safe, as if you get more
than 1024 children reaped (assuming you send two bytes of pid and two
bytes of status) between checks of the pipe, you'll lose notifications.
Admittedly this should be a problem in the sshd case, but it's not a
perfect solution in general. 

At least if you're only using the pipe to stop select() from blocking,
you don't care about overflowing the pipe as there's no important
information in there anyway.

Paul

