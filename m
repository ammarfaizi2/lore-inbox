Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSHHTPJ>; Thu, 8 Aug 2002 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSHHTPJ>; Thu, 8 Aug 2002 15:15:09 -0400
Received: from holomorphy.com ([66.224.33.161]:45722 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317852AbSHHTPI>;
	Thu, 8 Aug 2002 15:15:08 -0400
Date: Thu, 8 Aug 2002 12:18:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: further IO-APIC oddities
Message-ID: <20020808191851.GE15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20020808162856.GD6256@holomorphy.com> <70720000.1028829388@flay> <20020808180743.GD15685@holomorphy.com> <73720000.1028830446@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <73720000.1028830446@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> It's different from 2.5.29, I can follow up with that. 2.5.29 saw all 0's,
>> so whatever it was that was scribbling over the MPC table and making the
>> ID's all 0, it's scribbling on something else now (probably mem_map).

On Thu, Aug 08, 2002 at 11:14:06AM -0700, Martin J. Bligh wrote:
> I thought that was only if you reduced NR_CPUS? And you shouldn't
> need to read the IOAPIC tables to do that - the basic array was getting
> overwritten. Or am I confusing at least two different bugs?

Sorry, I'm being obtuse. What I had in mind here was:

(1) there's been a longstanding bug where the MPC table entries with
	the IO-APIC ID's gets zeroed out
(2) this bug mysteriously went away, even though we never tracked it down
(3) bugs that smell of mem_map getting stomped on are cropping up

... and I suspect these three things are related, e.g. the MPC stuff moved
or link order changed or some such Heisenbug-ish nonsense and now it's
hitting something else. The NR_CPUS bit isn't even bootable (the panic()
happens before console_init() IIRC) so it's not quite that one. =)

Cheers,
Bill
