Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161305AbWG1VTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbWG1VTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWG1VTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:19:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:22542 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161305AbWG1VTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:19:05 -0400
Date: Fri, 28 Jul 2006 17:19:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: cpufreq@lists.linux.org.uk
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: cpufreq notifier initialization
Message-ID: <Pine.LNX.4.44L0.0607281710090.5679-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to modify the cpufreq_transition_notifier_list.  Currently it is a
source of problems during swsusp, because the suspend and resume methods
invoke the notifier chain at a time when the down_read() operation
protecting the chain is not legal.

If the notifier chain is protected by SRCU ("Sleepable RCU", recently
added to -mm) instead of an rwsem, the problems would go away.  However 
SRCU requires runtime initialization.  This means the notifier chain's 
head has to be initialized before any listeners register on it and before 
the chain is ever invoked.

Can anyone tell me where a good place would be to do the initialization?  
It has to be early enough that nobody has used the transition notifier 
list but late enough that per-CPU data can be allocated.

Alan Stern

