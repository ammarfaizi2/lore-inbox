Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTANRum>; Tue, 14 Jan 2003 12:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTANRum>; Tue, 14 Jan 2003 12:50:42 -0500
Received: from isis.cs3-inc.com ([207.224.119.73]:13309 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id <S264863AbTANRul>;
	Tue, 14 Jan 2003 12:50:41 -0500
Date: Tue, 14 Jan 2003 10:00:32 -0800
Message-Id: <200301141800.h0EI0WS13467@isis.cs3-inc.com>
From: don-linux@isis.cs3-inc.com (Don Cohen)
To: linux-kernel@vger.kernel.org
cc: morgan@transmeta.com
Subject: execve setting capabilities incorrectly ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc me in replies.

quoting from message dated 1998/06 to this list from Andrew Morgan
 Subject: Fwd: Re: Capabilities 
 ...
 [root@godzilla progs]# ./execcap cap_net_bind_service=i sleep 1000 &
 [1] 600
 [root@godzilla progs]# cat /proc/600/status 
 ...
 CapInh: 0000000000000400
 CapPrm: 0000000000000400
 CapEff: 0000000000000400

My corresponding output ends up with
 CapInh: 0000000000000400
 CapPrm: 00000000fffffeff
 CapEff: 00000000fffffeff

I've tried in 2.4.18 and in 2.2.16, both give the same result so
I guess it's been this way for some time.

The caps seem to be set correctly by execcap but execve resets them. 
Is this intentional?  
If so, how is one now supposed to get the desired effects? 


What's really weird (can someone explain this?) is that things
seem to work better under strace:
 strace ./execcap = head <some file root has no permission to read>
=> permission denied
whereas without the strace it reads the file.

