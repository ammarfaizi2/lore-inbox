Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132522AbRAXVly>; Wed, 24 Jan 2001 16:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAXVlf>; Wed, 24 Jan 2001 16:41:35 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:47382 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132522AbRAXVlc>; Wed, 24 Jan 2001 16:41:32 -0500
Message-ID: <3A6F4B89.7539ADEB@sgi.com>
Date: Wed, 24 Jan 2001 15:39:21 -0600
From: Sam Watters <watters@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hpc-linux@relay2.corp.sgi.com,
        pagg@oss.sgi.com, slinx@ironwood-e101.americas.sgi.com
Subject: [ANNOUNCE]: PAGG & Job module for Linux 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Los Alamos National Laboratory (LANL) and SGI collaborated
to provide an accounting solution called Comprehensive System
Accounting (CSA).  CSA is for demanding Linux users who require the
ability to track system resource utilization and charge back the cost
of those resources used to the actual users who consume them.  To
accomplish this task, CSA performs job level accounting, as opposed to
the more familiar process level accounting (for CSA information see,
http://oss.sgi.com/projects/csa). CSA requires that a job container for
processes be made available on Linux.

A job is defined as a group of related processes, all descended from a
point of entry process and identified by a unique job ID. A job can
contain multiple process groups, session, and processes.  The job acts
as a process containment mechanism and a process is not allowed to
escape from the job container.

To provide a job container on Linux, we are proposing a generalized
mechanism for providing process containers.  We call this mechanism
Process Aggregates, or PAGGs.  PAGG will allow job containers to be
provided as a Linux kernel module, greatly lessening the impact of
providing jobs on the base Linux kernel.  In addition, other developers
can use PAGG to provide additional process container types.  In
addition to the job module using PAGG, we expect to provide a PAGG
module to further assist with managing parallel process applications
such as MPI applications in the near future.

PAGG consists of a set of kernel changes that provide functions for
modules to register and unregister as providers of process aggregate
containers.  The registration functions operate in much the same manner
as those currently provided for filesystems, block and character
devices, symbol tables, and execution domains.

The code changes are organized so that compiling them into the kernel is
optional.  In cases where PAGG support is compiled into the kernel, but
no PAGG modules are in use, the added burden to the kernel consists of
the execution of an additional if statment at process fork and another
at process exit.

In addition to the registration functions, the PAGG changes provide
hooks for updating process aggregate containers when processes fork and
exit.  In addition, a new paggctl system call is proposed to allow the
following types of services:

  1) creation of a new pagg container
  2) signal all processes that are attached to the pagg container
  3) wait for the completion of all processes in the pagg container
  4) future resource limit capabilities based upon pagg container

Each pagg module would handle their own paggctl requests.

Please see http://oss.sgi.com/projects/pagg for information on the
proposed kernel changes and further description of what PAGG is and why
we are proposing this work.  This page has a link to download the patch,
module, and commands source.  If you just want to ftp it directly you 
can get it at ftp://oss.sgi.com/projects/pagg/download.

A description of these kernel changes is provided at the PAGG project
home page (http://oss.sgi.com/projects/pagg) or you may access it
directly at http://oss.sgi.com/projects/pagg/pagg-lkd.txt.  

Currenlty, we have only implemented this on the i386 architecture.  And
ia64 version will soon be out as well.  We are going to make an attempt
to
get it working on the other arhitectures,  but we don't have the
facilities to test on all of the architectures.  Once we have all the
architectures covered and this goes through a period of comments, we
would like to try to get the resulting patch included in the Linux base
source. 

So, here is the job container.  We are now working on implementing
job-based limits.  Any comments and guidance concerning the PAGG and
Jobs work would be greatly appreciated.



-- 
Sam Watters		Resource Mgmt Team	SGI	watters@sgi.com
watters@sgi.com
(651)683-5647
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
