Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVHDRLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVHDRLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVHDRIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:08:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21240 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262634AbVHDRHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:07:18 -0400
Message-ID: <42F24AC4.5080103@mvista.com>
Date: Thu, 04 Aug 2005 10:05:08 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
References: <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com>
In-Reply-To: <20050804051434.GA4520@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
~
> Sorry, I forgot that sys_nanosleep() also always adds 1 to the request
> (to account for this same issue, I believe, as POSIX demands no early
> return from nanosleep() calls). There are some other locations where
> similar
> 
> 	+ (t.tv_sec || t.tv_nsec)

This is not the same as "always add 1".  We don't do it this way just to 
have fun with C.  If you change schedule_timeout() to add the 1, 
nanosleep() will need to do things differently to get the same behavior. 
  (And, YES users do pass in zero sleep times.)


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
