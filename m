Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbTCTXv3>; Thu, 20 Mar 2003 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262969AbTCTXv3>; Thu, 20 Mar 2003 18:51:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32785 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262933AbTCTXv2>; Thu, 20 Mar 2003 18:51:28 -0500
Message-ID: <3E7A567E.3080409@zytor.com>
Date: Thu, 20 Mar 2003 16:02:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t and major/minor split
References: <b5dckh$lv1$1@cesium.transmeta.com> <20030320220901.GR2835@ca-server1.us.oracle.com> <3E7A4977.5090700@zytor.com> <20030320234946.GT2835@ca-server1.us.oracle.com>
In-Reply-To: <20030320234946.GT2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Mar 20, 2003 at 03:06:31PM -0800, H. Peter Anvin wrote:
> 
>>Last I checked, all traditional (inode-based) Unix filesystems,
>>including ext2/3 used block pointers for dev_t.  There are plenty of
>>block pointers; 60 bytes worth.
> 
> 	They do indeed.  But ext2/3 touches that block pointer with
> cpu_to_le32() and friends.  It needs fixing at best, and compatability
> work for already existing partitions.
> 

A few options:

a) Use an inode flag indicating a large dev_t.  This is probably the
best option.

b) Use a sentinel value, e.g. 0xffffffff, to indicate that the major and
minor are in block pointers 1 and 2.

	-hpa


