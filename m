Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRBTNUq>; Tue, 20 Feb 2001 08:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129612AbRBTNUh>; Tue, 20 Feb 2001 08:20:37 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33799 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129592AbRBTNU0>;
	Tue, 20 Feb 2001 08:20:26 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Peter Samuelson <peter@cadcamlab.org>
Date: Tue, 20 Feb 2001 14:19:01 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] new setprocuid syscall
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1605A1153EC8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 01 at 7:11, Peter Samuelson wrote:
> [Alan Cox]
> > There is an assumption in the kernel that only the task changes its
> > own uid and other related data.
> 
> Fair enough but could you explain the potential problems?  And how is
> it different from sys_setpriority?

Look at what fs/open.c:sys_access does, at least. It switches
fsuid/fsgid/capabilities during its execution.

sys_setpriority is completely different, no piece of kernel changes that
and nothing except schedule() touches that. But {,fs,e}[ug]id are used
here and there through whole kernel. Also, changing priority does not
remove some access rights from your process, while changing uid/gid does...
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
