Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUHEREj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUHEREj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHEREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:04:07 -0400
Received: from holomorphy.com ([207.189.100.168]:51140 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267801AbUHERBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:01:38 -0400
Date: Thu, 5 Aug 2004 10:01:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: colpatch@us.ibm.com, Paul Jackson <pj@sgi.com>, zwane@linuxpower.ca,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040805170123.GB17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, colpatch@us.ibm.com,
	Paul Jackson <pj@sgi.com>, zwane@linuxpower.ca,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com> <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com> <20040801124053.GS2334@holomorphy.com> <20040801060529.4bc51b98.pj@sgi.com> <20040801131004.GT2334@holomorphy.com> <20040801063632.66c49e61.pj@sgi.com> <20040801134112.GU2334@holomorphy.com> <1091484032.4415.55.camel@arrakis> <871xiljzqo.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xiljzqo.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:
>>  #define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
>>  static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
>>  {
>> -	return find_next_bit(srcp->bits, nbits, n+1);
>> +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
>>  }

On Fri, Aug 06, 2004 at 01:50:23AM +0900, OGAWA Hirofumi wrote:
> Shouldn't these use simply min()?  I worry min_t() may hide the real bug...

min_t() is harmless here. Some 64-bit architectures use long as the
return type of find_next_bit(), but its precision isn't needed, so
min_t() merely prevents up a useless warning.


-- wli
