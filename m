Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTHTUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTHTUuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:50:16 -0400
Received: from imr2.ericy.com ([198.24.6.3]:58327 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S262032AbTHTUuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:50:08 -0400
From: "Frederic Rossi (QB/EMC)" <frederic.rossi@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16195.57060.748443.530267@localhost.localdomain>
Date: Wed, 20 Aug 2003 16:49:40 -0400
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Supporting asynchronous events in Linux with AEM
X-Mailer: VM 7.07 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi everyone,

I'd like to announce the availability of AEM (async. event mech.). This 
project is an attempt to provide a generic and native support for 
asynchronous events in the Linux kernel. 

See below for an overview of AEM. More information can be found here
http://aem.sourceforge.net

Your comments are valuable and I will be pleased to get any feedback from you. 

Frederic


Overview
--------

The primary objective of AEM is to provide a native kernel mechanism, which 
doesn't make use of other techniques to support the semantic. The reason behind 
this is to be able to handle a very huge number of events in a scalable and 
responsive way. 

Basically, AEM allows an application to register to system events 
by supplying user-space event handlers during registration. When an event 
occurs in the kernel the corresponding event handler is executed 
with the data in parameter. 

AEM is a communication mechanism more than a notification mechanism in the
sense the main goal is really to pass information quickly from the kernel to the 
user space applications, both ways. This means the data can be modified by event
handlers and be re-interpreted when back into the kernel.

The second goal behind AEM is to provide the atomic execution of user space
handlers directly in reaction to events. Priorities can be associated with events
to give high priority events the possibility to boost their corresponding
processes. As opposed to other styles of event monitoring mechanisms AEM is
working bottom-up, i.e user processes are executed/created by system events.

Generally, we assume that event handlers are short lived executing 
quickly in the same execution context as the calling process. But if necessary 
an event handler can also be executed inside a new process context permitting its 
execution in parallel with the main thread of execution. In this case, processes 
are created on the fly.

I'm taking special care to integrate AEM with existing mechanisms providing 
similar, although different, functionalities. I want to stress the fact that 
the goal of AEM is not to replace what already exist but to provide a 
complementary support in Linux. 

I'm conscious the current implementation is not perfect and a lot of 
work is still to be done. Any suggestion for improvement is welcome.

Current status
--------------

Specific structures and activation points for events must be present in the 
kernel. This is implemented by a patch supplying this basic infrastructure. 

The whole implementation is provided by independent kernel modules. One 
module supplies the core functionalities while the other modules supply 
specific implementations of event handling mechanisms (fetching and 
handling of data). Also, definitions of the calling APIs are implemented
by modules.

This architecture is very flexible. Different implementations can coexist
in the same time. This gives the possibility to stay compatible in 
case of a change of API or semantics.

AEM is currently supported on Linux kernels 2.6.0-test1 and 2.4.20.
