Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVBOTei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVBOTei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBOTei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:34:38 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58783 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261835AbVBOTdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:33:31 -0500
Date: Tue, 15 Feb 2005 13:29:06 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Williams <pwil3058@bigpond.net.au>
Subject: [ANNOUNCE 0/4] Genetic-lib version 0.2
Message-Id: <20050215132906.33f88505.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the next release of the genetic library based against 2.6.10
kernel.

There were numerous changes from the first release, but the major change
in this version is the introduction of phenotypes.  A phenotype is a set
of genes the affect an observable property.  In genetic-library terms,
it is a set of genes that will affect a particular fitness measurement. 
Each phenotype will have a set of children that contain genes that
affect a fitness measure.  

Now multiple fitness routines can be ran for each genetic library user.
Then depending on the results of a particular fitness measure, the
specific genes that directly affect that fitness measure can be
modified.  This introduces a finer granularity that was missing in the
first release of the genetic-library.  

I would like to thank Peter Williams for reworking the Zaphod Scheduler
and help designing the phenotypes.

Some of the other features introduced is shifting the number of
mutations depending on how well a phenotype is performing.  If the
current generation outperformed the previous generation, then the rate
of mutation will go down.  Conversely if the current generation performed
worst then the previous generation, the mutation rate will go up.  This
mutation rate shift will do two things.  When generations are improving,
it will reduce the number unnecessary mutations and hone in on the
optimal tunables.  When a workload drastically changes, the fitness
should go way down, and the mutation rate will increase in order to test
a greater space of better values quicker.  This should decrease the time
it takes to adjust to a new workload.  There is a limit at 45% of the
genes being mutated every generation in order to prevent the mutation
rate spiralling out of control. 

SpecJBB and UnixBench are still yielding a 1-3% performance improvement,
however (though it's subjective) the interactiveness has had noticeable
improvements.

I have not broke the Anticipatory IO Scheduler down to a fine
granularity in phenotypes yet.  Any assistance would be greatly
appreciated.

Currently I am hosting this project off of:

	http://kernel.jakem.net

[1/4 genetic-lib]: This is the base patch for the genetic algorithm.

[2/4 genetic-io-sched]: The base patch for the IO schedulers to use the
       genetic library.

[3/4 genetic-as-sched]: A genetic-lib hooked anticipatory IO scheduler.

[4/4 genetic-zaphod-cpu-sched]: A hooked zaphod CPU scheduler.  Depends
       on the zaphod-v6.2 patch.

Thanks,
Jake

