Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSHIIo1>; Fri, 9 Aug 2002 04:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318193AbSHIIo1>; Fri, 9 Aug 2002 04:44:27 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4360 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318191AbSHIIo0>; Fri, 9 Aug 2002 04:44:26 -0400
Message-ID: <3D5381F7.1BCE0118@aitel.hist.no>
Date: Fri, 09 Aug 2002 10:48:55 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
References: <200208090704.g7974Td55043@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:

> The problem is screen space, pure and simple. If the
> default limit goes to over 1 billion, then "ps" output
> must wrap lines. There is no alternative, unless you
> think "System going down to reset PID numbers!" is OK.
> 

There is an alternative.  
Use 32-bit PID's, but with an additional rule for wraparound.
Simply wrap the PID when 
(nextPID > 2*number_of_processes && nextPID > 30000)
The latter one just to avoid wrapping at 10 when there are 
5 processes.  

This simple approach supports 32-bit PIDs for those 
that need them, while "ps" and friends always looks nice 
except for those who actually run large amounts of processes.
You won't get a very large PID unless you need to.

Helge Hafting
