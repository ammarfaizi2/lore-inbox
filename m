Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUKWJZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUKWJZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUKWJZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:25:54 -0500
Received: from andrew.triumf.ca ([142.90.106.59]:18380 "EHLO andrew.triumf.ca")
	by vger.kernel.org with ESMTP id S262389AbUKWJZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:25:46 -0500
Date: Tue, 23 Nov 2004 01:25:45 -0800 (PST)
From: Andrew Daviel <advax@triumf.ca>
X-X-Sender: andrew@andrew.triumf.ca
To: linux-kernel@vger.kernel.org
Subject: towards dynamic resource quotas
Message-ID: <Pine.LNX.4.53.0411230035350.28029@andrew.triumf.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any mechanism within Linux to limit the fraction of a resource
(CPU, memory, network bandwidth) which may be allocated to a particular
process or UID ? If not, perhaps there should be. The idea being to
ensure that critical tasks can always run, regardless of resource
depletion by other tasks

As I understand things, at present there is a disk quota system, and the
rlimit mechanism which may be used to limit memory, total CPU time,
number of processes etc. Not all of these are feasible to use
to limit the resources of a server process such as httpd
- a CPU limit would cause the process to die after N seconds of
CPU time, while what is desired is to limit the process to X % of CPU

 - I attended a conference recently on embedded systems, where the
penetration of Linux (and XP) into the embedded computing market was
discussed, along with the enhancements for pre-emptability in 2.6 and
security issues (patchability of embedded systems, sharing code base with
ubiquitous desktops & servers). It occurred to me that it would be
advantageous to have a system that could continue to function reliably,
even if infected with malware such as viruses or DDOS agents that would
otherwise saturate resources such as network connectivity or CPU.

I could imagine the following scenario: a device is developed which is
responsible for monitoring an implanted pacemaker and for administering
drugs as required to a heart patient. It has networking capability to
call a physician if required; let's make it smart enough to make an
"intelligent" call anywhere in the world.  Let's add a server (sshd
perhaps) for the physician to log in and check the history, and, though
it would be naive to trust a perimeter firewall in a hospital, let's make
it a wireless device and place it on an untrusted network. What happens
if the ssh server is exploited by an intruder to send spam, or a
programming error causes the emergency calling routine to loop if it
encounters a busy signal in the Guatamala phone system ? The primary
task, dispensing drugs, must continue to run even though another process
attempts to use 100% of CPU or 100% of network bandwidth.
It is not clear to me that existing mechanisms such as nice, rlimit or
pre-empting can guarantee this.


-- 
Andrew Daviel, TRIUMF, Canada
Tel. +1 (604) 222-7376
security@triumf.ca
