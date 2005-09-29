Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVI2Gtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVI2Gtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVI2Gtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:49:39 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:20827 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932099AbVI2Gtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2F4BrDURjQUzZMd7lC4f5LwX7FWfQO8pj2UwrPBlOwTmi0IvpFFLjT0HmWUDDoUxf9zNaxfGq/s7UBPDcBLQp0Z2SlDtndlP+VrtC/odD4RF9hwsuBqFokDC+ilJU9AiMPuRok8n+FIipcanecdmNXTT3X3mACoPDmUtdJcC+go=  ;
Message-ID: <433B8E76.9080005@yahoo.com.au>
Date: Thu, 29 Sep 2005 16:49:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Rohit Seth <rohit.seth@intel.com>, akpm@osdl.org, linux-mm@kvack.org,
       Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org,
       steiner@sgi.com
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
References: <20050928105009.B29282@unix-os.sc.intel.com>  <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>  <1127939185.5046.17.camel@akash.sc.intel.com>  <Pine.LNX.4.62.0509281408480.15213@schroedinger.engr.sgi.com> <1127943168.5046.39.camel@akash.sc.intel.com> <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>
>I know that Jack and Nick did something with those counts to insure that 
>page coloring effects are avoided. Would you comment?
>
>

The 'batch' argument to setup_pageset should be clamped to a power
of 2 minus 1 (ie. 15, 31, etc), which was found to avoid the worst
of the colouring problems.

pcp->high of the hotlist IMO should have been reduced to 4 anyway
after its pcp->low was reduced from 2 to 0.

I don't see that there would be any problems with playing with the
->high and ->low numbers so long as they are a reasonable multiple
of batch, however I would question the merit of setting the high
watermark of the cold queue to ->batch + 1 (should really stay at
2*batch IMO).

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
