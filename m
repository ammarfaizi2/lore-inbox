Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262985AbTDBMhF>; Wed, 2 Apr 2003 07:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTDBMhE>; Wed, 2 Apr 2003 07:37:04 -0500
Received: from [81.2.110.254] ([81.2.110.254]:37361 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S262985AbTDBMhE>;
	Wed, 2 Apr 2003 07:37:04 -0500
Subject: Re: ptrace patch fails stress testing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linas@austin.ibm.com
Cc: linas@linas.org, ppc@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401122256.A34952@forte.austin.ibm.com>
References: <20030401122256.A34952@forte.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049284187.16276.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2003 12:49:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 19:22, linas@austin.ibm.com wrote:
> The problem appears to be that task->mm is dereferenced without 
> looking to see if mm is NULL.  e.g. in the sched.h in the 
> is_dumpable() macro, we have task->mm->dumpable .  I'm sitting
> in front of a KDB session and I'm clearly looking at task->mm
> which is NULL. 
> Why, how and under what conditions this race condition occurs, 
> I don't know.  What the best fix is, I don't know.

Zombie process. The patch checks ->mm but must also check ->mm != NULL
first.


> I can try to just add a check for NULL, but I'd like someone 
> to tell me that 'yes this is the right way to fix this.' 

It is I think.


Alan
