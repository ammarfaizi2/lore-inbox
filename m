Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSECLLJ>; Fri, 3 May 2002 07:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315632AbSECLLJ>; Fri, 3 May 2002 07:11:09 -0400
Received: from holomorphy.com ([66.224.33.161]:51162 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315631AbSECLLG>;
	Fri, 3 May 2002 07:11:06 -0400
Date: Fri, 3 May 2002 04:09:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503110950.GI24506@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <20020503080433.R11414@dualathlon.random> <20020503092426.GH24506@holomorphy.com> <20020503123009.P11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 12:30:09PM +0200, Andrea Arcangeli wrote:
> Putting the mem_map in highmem would be the first step, after that you
> should be just at at the 90% of work done to make it general purpose,
> you should wrap most actions on the page struct with wrappers and it
> will be quite an invasive change (much more invasive than pte-highmem),
> but it could be done. For this one (unlike pte-highmem) you definitely
> need a config option to select it, most people doesn't need this feature
> enabled because they've less than 8G of ram and also considering it will
> have a significant runtime cost.

Invasive or not, if running is impossible without it, it must be done.

This is a probable first order of business given that it is the single
largest consumer of KVA with only really enough mitigation for
bootability provided by my prior efforts at reducing the size of struct
page. A clean, perhaps even mergeable design for this would be a great
boon to all users of larger highmem systems. IIRC buffer_heads were the
specific reported problem, and though they themselves consume excessive
KVA only under some circumstances, they present a much greater danger
in combination with the excessively large boot-time KVA allocation.

Martin, can you take over? I've got plenty of ideas about what to code
up, but you've actually got your hands on the machine and are knee-deep
in the issues. I'm getting hit up for specifics I can't answer.

Andrea, it might also be helpful to hear your input during the LSE
conference call tomorrow. The topic is KVA exhaustion scenarios, which
seem to be of interest to you as well.


Cheers,
Bill
