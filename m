Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWISVhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWISVhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWISVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:37:21 -0400
Received: from motgate3.mot.com ([144.189.100.103]:51410 "EHLO
	motgate3.mot.com") by vger.kernel.org with ESMTP id S1750769AbWISVhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:37:19 -0400
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Tue, 19 Sep 2006 16:37:04 -0500 (CDT)
Message-Id: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: eugeny.mints@gmail.com
CC: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-reply-to: "Eugeny S. Mints"'s message of Mon, 18 Sep 2006 23:58:04 +0400
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eugeny S. Mints" <eugeny.mints@gmail.com>

| Eugeny S. Mints wrote:
| > Pavel Machek wrote:
| >> Hi!
| >>
| [skip]
| >> How is it going to work on 8cpu box? will
| >> you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
| 
| basically I guess you are asking about what the names of operating
| points are and how to distinguish between operating points from
| userspace on 8cpu box.
| 
| An advantage of PowerOP approach is that operating point name is used as
| a _handle_ and may or may not be meaningful. The idea is that if a
| policy manager needs to make a decision and needs to distinguish between
| operating points it can check value of any power parameters of operating
| points in question. Power parameter values may be obtained under
| <op_name> dir name.
| 
| With such approach a policy manger may compare operating points at
| runtime and should not rely on compile time knowledge about what name
| corresponds to what set of power parameter values. It uses name as a
| handle.
---

Hmm. If you assume the CPUs in an SMP system can be in different
operating points, this would (as Pavel pointed out) result in an
explosion of operating points.

I see several possible responses to this problem:

(1) Make operating points a CPU-level abstraction, rather than a
system-level abstraction, with the set of OPs for each CPU defined
individually. This allows for non-symmetric CPUs. Each CPU would have
its own policy manager driving OP selection for that CPU (the set of
policy managers could be shared, as I believe cpufreq shares governors
among CPU).

(2) Create CPU-group operating points that captured the power
parameters for each of a set of CPUs (that is, a group OP would be a
vector of CPU OPs).

(3) Create CPU-group operating points that varied a group of CPUs
symetrically (that is, one set of CPU-level power parameters shared
across a set of CPUs), with group-level policy managers that control
transitions for the group in lockstep. 

(4) Create CPU-group operating points that varied a group of CPUs
symetrically (as in (3)), and have both group-level policy managers and
a system-level policy manager that moves CPUs from one group to
another.

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


