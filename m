Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSHIJIl>; Fri, 9 Aug 2002 05:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318193AbSHIJIl>; Fri, 9 Aug 2002 05:08:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16635 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318207AbSHIJIk>; Fri, 9 Aug 2002 05:08:40 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3D5381F7.1BCE0118@aitel.hist.no>
References: <200208090704.g7974Td55043@saturn.cs.uml.edu> 
	<3D5381F7.1BCE0118@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 11:32:33 +0100
Message-Id: <1028889153.28883.186.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 09:48, Helge Hafting wrote:
> Use 32-bit PID's, but with an additional rule for wraparound.
> Simply wrap the PID when 
> (nextPID > 2*number_of_processes && nextPID > 30000)
> The latter one just to avoid wrapping at 10 when there are 
> 5 processes.  

Its much simpler to put max_pid into /proc/sys/kernel. That way we can
boot with 32000 process ids, which will ensure ancient stuff which has
16bit pid_t (old old libc) and also any old kernel interfaces which
expose it - does ipc ? 

