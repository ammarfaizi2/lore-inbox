Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbTCRCn5>; Mon, 17 Mar 2003 21:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCRCnz>; Mon, 17 Mar 2003 21:43:55 -0500
Received: from holomorphy.com ([66.224.33.161]:64988 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262112AbTCRCnx>;
	Mon, 17 Mar 2003 21:43:53 -0500
Date: Mon, 17 Mar 2003 18:54:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] GFP_ZONEMASK vs. MAX_NR_ZONES
Message-ID: <20030318025424.GV20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <3E767C04.3000604@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E767C04.3000604@us.ibm.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 05:53:08PM -0800, Matthew Dobson wrote:
> node_zonelists looks like it should really be declared of size 
> MAX_NR_ZONES, not GFP_ZONEMASK.  GFP_ZONEMASK is currently 15, making 
> node_zonelists an array of 16 elements.  The extra zonelists are all 
> just duplicates of the *real* zonelists, namely the first 3 entries. 
> Again, if anyone can explain to me why I'm wrong in my thinking, I'd 
> love to know.  There's certainly no way you could bitwise-and something 
> with any combination of the GFP_DMA and GFP_HIGHMEM flags to refer to 
> the 12th zonelist or some such!  Or am I crazy?

No, you're not crazy, you're right:

#define __GFP_DMA       0x01
#define __GFP_HIGHMEM   0x02

/* Action modifiers - doesn't change the zoning */
#define __GFP_WAIT      0x10    /* Can wait and reschedule? */
#define __GFP_HIGH      0x20    /* Should access emergency pools? */
#define __GFP_IO        0x40    /* Can start physical IO? */
#define __GFP_FS        0x80    /* Can call down to low-level FS? */
#define __GFP_COLD      0x100   /* Cache-cold page required */
#define __GFP_NOWARN    0x200   /* Suppress page allocation failure warning */

bits 3-6 of gfp masks are totally unused.


-- wli
