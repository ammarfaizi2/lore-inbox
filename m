Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272620AbTG3Bbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272631AbTG3Bbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:31:43 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:63667
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272620AbTG3Bbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:31:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Diego Calleja =?iso-8859-15?q?Garc=EDa?= <diegocg@teleline.es>
Subject: Re: [PATCH] O10int for interactivity
Date: Wed, 30 Jul 2003 11:36:06 +1000
User-Agent: KMail/1.5.2
Cc: miller@techsource.com, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200307280112.16043.kernel@kolivas.org> <200307300035.01354.kernel@kolivas.org> <20030730031616.3ed14362.diegocg@teleline.es>
In-Reply-To: <20030730031616.3ed14362.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307301136.06396.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 11:16, Diego Calleja García wrote:
> El Wed, 30 Jul 2003 00:35:01 +1000 Con Kolivas <kernel@kolivas.org> 
escribió:
> > That's not as silly as it sounds. In fact it should be dead easy to
> > increase/decrease the amount of anticipatory time based on the bonus from
> > looking at the code. I dunno how the higher filesystem gods feel about
> > this though.
>
> I've done a small patch (one line) which tries to implement that.
> At as-iosched.c:as_add_request() there's:

The logic is in the difference between the dynamic and the static priority to 
determine if a task is interactive. 
current->static_prio - current->prio
will give you a number of -5 to +5, with +5 being a good bonus and vice versa.
however you need to ensure that the value you are fiddling with in the i/o 
scheduler is actually due to the current process[1]

On top of that, the p->prio itself will give you a number of 0-140 depending 
with higher being a lower priority task; numbers 100-140 are for user tasks 
and <100 for real time tasks. 

These all change if you fiddle with the magic in bonus ratios and max rt prio 
etc.

Con

[1] This is why I didn't bother posting my attempts ;)

