Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbULILcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbULILcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 06:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULILcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 06:32:48 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:38331 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261508AbULILcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 06:32:43 -0500
Message-ID: <41B837D6.2000504@yahoo.com.au>
Date: Thu, 09 Dec 2004 22:32:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Christoph Lameter <clameter@sgi.com>, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
References: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]> <41AEC4D7.4060507@pobox.com> <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com> <20041209105753.GB1131@elf.ucw.cz>
In-Reply-To: <20041209105753.GB1131@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>Standard Kernel on a 512 Cpu machine allocating 32GB with an increasing
>>number of threads (and thus increasing parallellism of page faults):
>>
>> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>> 32   3    1    1.416s    138.165s 139.050s 45073.831  45097.498
> 
> ...
> 
>>Patched kernel:
>>
>>Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>> 32   3    1    1.098s    138.544s 139.063s 45053.657  45057.920
> 
> ...
> 
>>These number are roughly equal to what can be accomplished with the
>>page fault scalability patches.
>>
>>Kernel patches with both the page fault scalability patches and
>>prefaulting:
>>
>> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>> 32  10    1    4.103s    456.384s 460.046s 45541.992  45544.369
> 
> ...
> 
>>The fault rate doubles when both patches are applied.
> 
> ...
> 
>>We are getting into an almost linear scalability in the high end with
>>both patches and end up with a fault rate > 3 mio faults per second.
> 
> 
> Well, with both patches you also slow single-threaded case more than
> twice. What are the effects of this patch on UP system?

fault/wsec is the important number.

