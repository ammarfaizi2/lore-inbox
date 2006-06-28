Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWF1Li1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWF1Li1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWF1Li1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:38:27 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:65482 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932785AbWF1Li0
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 28 Jun 2006 07:38:26 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17570.26897.378682.724475@gargle.gargle.HOWL>
Date: Wed, 28 Jun 2006 15:33:37 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Newsgroups: gmane.linux.kernel
In-Reply-To: <6694B22B6436BC43B429958787E4549802394A55@mssmsx402nb>
References: <6694B22B6436BC43B429958787E4549802394A55@mssmsx402nb>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > >From Leonid Ananiev

Hello,

 > 
 > Moving dirty pages balancing from user to kernel thread pdfludh entirely
 > reduces extra long write(2) latencies, increases performance.
 > 

[...]

 > 	The benchmarks IOzone and Sysbench for file size 50% and 120% of
 > RAM size on Pentium4, Xeon, Itanium have reported write and mix
 > throughput increasing about 25%. The described Iozone > 0.1 sec write(2)

Results are impressive.

Wouldn't this interfere with current->backing_dev_info logic? This field
is set by __generic_file_aio_write_nolock() and checked by
may_write_to_queue() to force heavy writes to do more pageout. Maybe
pdflush threads should set this field too?

 > latencies are deleted. The condition writeback_in_progress() is tested
 > earlier now. As a result extra pdflush works are not created and number
 > of context switches increasing is inside variation limites.

Nikita.
