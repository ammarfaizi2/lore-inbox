Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRALME3>; Fri, 12 Jan 2001 07:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbRALMET>; Fri, 12 Jan 2001 07:04:19 -0500
Received: from hermes.mixx.net ([212.84.196.2]:27410 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131138AbRALMEN>;
	Fri, 12 Jan 2001 07:04:13 -0500
Message-ID: <3A5EF208.4013B5F7@innominate.de>
Date: Fri, 12 Jan 2001 13:01:12 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <20010112031247.E10035@nightmaster.csn.tu-chemnitz.de> <24827.979266656@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> I want to completely remove this multi layered method for setting
> initialisation order and go back to basics.  I want the programmer to
> say "initialise E and F after G, H and I".  The kernel build system
> works out the directed graph of initialisation order then controls the
> execution of startup code to satisfy this graph.

I don't doubt you will come up with a workable solution at build time. 
However, working out a valid graph at execution time is trivial and
efficient, given a list of precedence relations of the kind you're
suggesting.  In fact you don't even have to work out the graph before
starting the initialization, it's also trivial to keep a count of
unsatisfied initialization conditions at the beginning of each
initialization sequence and block until the count goes to zero.  (In
essence, evaluate a priority sort on the fly.)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
