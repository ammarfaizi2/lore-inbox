Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265670AbTFNNgf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbTFNNge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:36:34 -0400
Received: from holomorphy.com ([66.224.33.161]:34953 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265670AbTFNNgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:36:18 -0400
Date: Sat, 14 Jun 2003 06:49:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC] recursive pagetables for x86 PAE
Message-ID: <20030614134927.GH26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oliver Neukum <oliver@neukum.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <1055540875.3531.2581.camel@nighthawk> <200306141327.48649.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306141327.48649.oliver@neukum.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. Juni 2003 23:47 schrieb Dave Hansen:
>> When you have lots of tasks, the pagetables start taking up lots of
>> lowmem.  We have the ability to push the PTE pages into highmem, but
>> that exacts a penalty from the atomic kmaps which, depending on
>> workload, can be a 10-15% performance hit.
>> The following patches implement something which we like to call UKVA.
>> It's a Kernel Virtual Area which is private to a process, just like
>> Userspace.  You can put any process-local data that you want in the
>> area.  But, for now, I just put PTE pages in there.

On Sat, Jun 14, 2003 at 01:27:48PM +0200, Oliver Neukum wrote:
> If you put only such pages there, do you really want that memory to
> be per task? IMHO it should be per memory context to aid threading
> performance.

Per-process is essentially per-mm.


On Sat, Jun 14, 2003 at 01:27:48PM +0200, Oliver Neukum wrote:
> Secondly, doesn't this scream for using large pages?

No, 2MB/4MB pages are not useful here.


-- wli
