Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWAQO6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWAQO6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWAQO6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:58:52 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:23749 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750915AbWAQOud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:33 -0500
Message-Id: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:32:58 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 00/34] PID Virtualization Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
PID Virtualization is based on the concept of a container.
Our ultimate goal is to checkpoint/restart containers.  The
containers should also be useful as a basis for the pid
virtualization required, for instance, by vserver.

The mechanism to start a container 
is to 'echo "container_name" > /proc/container'  which creates a new
container and associates the calling process with it. All subsequently
forked tasks then belong to that container.
There is a separate pid space associated with each container.
Only processes/task belonging to the same container "see" each other.
The exception is an implied default system container that has 
a global view.
The following patches accomplish 3 things:
1) identify the locations at the user/kernel boundary where pids and 
   related ids ( pgrp, sessionids, .. ) need to be (de-)virtualized and
   call appropriate (de-)virtualization functions.
2) provide the virtualization implementation in these functions.
3) implement a container object and a simple /proc interface to create one
4) provide a per container /proc/fs

-- Hubertus Franke    (frankeh@watson.ibm.com)
-- Cedric Le Goater   (clg@fr.ibm.com)
-- Serge E Hallyn     (serue@us.ibm.com)
-- Dave Hansen        (haveblue@us.ibm.com)

