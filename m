Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUE0QHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUE0QHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUE0QHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:07:04 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:19782 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264861AbUE0QGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:06:55 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200405271606.i4RG6IYC001896@ben.americas.sgi.com>
Subject: Re: Hot plug vs. reliability
To: Zoltan.Menyhart@bull.net
Date: Thu, 27 May 2004 11:06:18 -0500 (CDT)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <40B5D68C.466FE969@nospam.org> from "Zoltan Menyhart" at May 27, 2004 01:52:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:
> 
> We cannot remove safely failing memory / CPUs. In most of the cases
> it is too late. 

This is a key point.  To get the most value out of hot plug (as
a reliability feature) the system must be able to detect and
"ride through" component failures.  Conversly, if the system
crashes on the first component failure, the ability to hot remove
the broken component has little value.

For example, memory hot-plug has the most value if the system can
"ride through" a memory uncorrectable, isolate the bad memory 
(ie not re-use the page with the bad DIMM cells), shoot the application
that hit the uncorrectable (or better yet, have some checkpoint/restart
mechanism to avoid killing the application), migrate data off
the physical DIMM (etc) to get the system to the point that the
bad DIMM can be physically replaced, and re-integrate the new memory.

My point is that a key part of the whole hot plug story is the
ability to detect and ride thought the initial errors that would
prompt someone to want to replace the component.  And without that
part the significant effort to do the rest of the pieces has significantly
less value.

>                  We (in the OS) can see some corrected CPU, memory, I/O
> and platform errors. Yet the OS has not got and should not have the
> knowledge when a component is "enough bad". I think it is the firmware
> that has all the information about the details of the HW events.
> Do you know of some firmware services which can say something like:
> "hey, remove the component X otherwise your MTBF will drop by 95 %..." ?

The difficulty with predictive analysis is determining the exact
indicator of a potential failure.  Many times the first indication
is a fatal error that crashes the system (which is why error recovery
to "ride through" failures is so important).  Other errors, such 
as memory singlebits, may (or may not) increase the probability of
failure, but does is increase the probability enough to warrent
a service action?  (Service actions have costs, too.)

A technical difficulty with predictive analysis is that each component 
has a different failure characteristics and the failure charicteristics
can change with spacific technologies.  For example, smaller die 
technologies can increase the soft failure rates.  And by the 
time the long term failure characteristics are fully understood 
the technology is obsolete.  :-(

-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
