Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWGCRb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGCRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWGCRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:31:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:58153 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751215AbWGCRb6 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:31:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8eWn+8uE+RO6I4Gr9Ga7+GIOBYxMC/sun2D17VsiJAZPqAacEPFzFTPxmEp0P2Vp28VrRD5tbUeWnLP6Zf6gZzMUC/ohLffGPZGrGNJw/tFk/eXJeJSY2hJfKYTARPqESGeigcI2zs94CZUDgrFLf1naAjNxxljs/Fj1YAkqfE=
Message-ID: <69304d110607031031j2b981ff5m571321deaf91f57d@mail.gmail.com>
Date: Mon, 3 Jul 2006 19:31:57 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Nikita Danilov" <nikita@clusterfs.com>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <17570.26897.378682.724475@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6694B22B6436BC43B429958787E4549802394A55@mssmsx402nb>
	 <17570.26897.378682.724475@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Nikita Danilov <nikita@clusterfs.com> wrote:
> Ananiev, Leonid I writes:
>  > >From Leonid Ananiev
>
> Hello,
>
>  >
>  > Moving dirty pages balancing from user to kernel thread pdfludh entirely
>  > reduces extra long write(2) latencies, increases performance.
>  >
>
> [...]
>
>  >      The benchmarks IOzone and Sysbench for file size 50% and 120% of
>  > RAM size on Pentium4, Xeon, Itanium have reported write and mix
>  > throughput increasing about 25%. The described Iozone > 0.1 sec write(2)
>
> Results are impressive.
>
> Wouldn't this interfere with current->backing_dev_info logic? This field
> is set by __generic_file_aio_write_nolock() and checked by
> may_write_to_queue() to force heavy writes to do more pageout. Maybe
> pdflush threads should set this field too?
>
>  > latencies are deleted. The condition writeback_in_progress() is tested
>  > earlier now. As a result extra pdflush works are not created and number
>  > of context switches increasing is inside variation limites.
>
> Nikita.

Maybe we should keep the sync-write logic if there is only one online
cpu, and thus avoiding extra context switches when they are not
profitable?

-- 
Greetz, Antonio Vargas aka winden of network
