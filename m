Return-Path: <linux-kernel-owner+w=401wt.eu-S1751643AbWLMW2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWLMW2S (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWLMW2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:28:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbWLMW2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:28:17 -0500
Date: Wed, 13 Dec 2006 17:26:16 -0500
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, norsk5@xmission.com,
       lkml <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [RFC] new MSR r/w functions per CPU
Message-ID: <20061213222616.GJ2418@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rudolf Marek <r.marek@assembler.cz>, norsk5@xmission.com,
	lkml <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	bluesmoke-devel@lists.sourceforge.net
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com> <45807C88.6060807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45807C88.6060807@zytor.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 02:19:52PM -0800, H. Peter Anvin wrote:

 > > void rdmsr_on_cpu(unsigned int cpu, unsigned long msr, unsigned long *lo, unsigned long *hi)
 > > {
 > >     cpumask_t oldmask;
 > > 
 > >     oldmask = current->cpus_allowed;
 > >     set_cpus_allowed(current, cpumask_of_cpu(cpu));
 > > 
 > > 	rdmsr(msr, &lo, &hi);
 > > 
 > >     set_cpus_allowed(current, oldmask);
 > > }
 > > 
 > 
 > [The above doesn't work, by the way.  This approach was discussed a long 
 > time ago, and vetoed due to the potential for deadlock.]

Can you explain this a little further? I'm fairly certain
there are places in the kernel already doing this (or similar).
In fact, I cut-n-pasted most of the above from similar code in the
powernow-k8 driver.  What exactly can we deadlock on?

		Dave

-- 
http://www.codemonkey.org.uk
