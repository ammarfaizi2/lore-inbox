Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUBFSlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:41:44 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:64181 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S265659AbUBFSlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:41:25 -0500
Date: Fri, 6 Feb 2004 10:37:46 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206183746.GR4902@ca-server1.us.oracle.com>
Mail-Followup-To: Werner Almesberger <wa@almesberger.net>,
	linux-kernel@vger.kernel.org
References: <20040206041223.A18820@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206041223.A18820@almesberger.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 04:12:24AM -0300, Werner Almesberger wrote:
> Section 2.9.7 of the "Austin" draft of IEEE Std. 1003.1-200x,
> 28-JUL-2000, says:
> 
> "[...] read( ) [...] shall be atomic with respect to each other
>  in the effects specified in IEEE Std. 1003.1-200x when they
>  operate on regular files. If two threads each call one of these
>  functions, each call shall either see all of the specified
>  effects of the other call, or none of them."

	This reads:  "all of the specified effects of the other call,
or none of them."  If I read that correctly, if f_pos is at N, and
threads A and B concurrently read M bytes, then each thread's read()
must either start at f_pos = N or f_pos = N+M, but never at N < f_pos <
N+M.  So as long as our code doesn't partially update f_pos, it is
valid.  
	Of course, that doesn't change the possible race updating
f_pos at the end of each thread's call.

Joel

-- 

"In a crisis, don't hide behind anything or anybody. They're going
 to find you anyway."
	- Paul "Bear" Bryant

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
