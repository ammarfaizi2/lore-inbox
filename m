Return-Path: <linux-kernel-owner+w=401wt.eu-S1751347AbWLSCf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWLSCf3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 21:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWLSCf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 21:35:28 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33011 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbWLSCf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 21:35:28 -0500
Date: Mon, 18 Dec 2006 20:34:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: schedule_timeout: wrong timeout value
In-reply-to: <fa.n+5Mb4OrI3NXIfyW+9Do6h0Q2UA@ifi.uio.no>
To: kyle <kylewong@southa.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <45874FC3.503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.n+5Mb4OrI3NXIfyW+9Do6h0Q2UA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kyle wrote:
> Hi,
> 
> Recently my mysql servershows something like:
> Dec 18 18:24:05 sql kernel: schedule_timeout: wrong timeout value 
> ffffffff from c0284efd
> Dec 18 18:24:36 sql last message repeated 19939 times
> Dec 18 18:25:37 sql last message repeated 33392 times
> 
> from syslog every 1 or 2 days. Whenever the messages show, mysql server 
> stop accept new connections from the same network, and I need to restart 
> the mysql service and then it will keep running well for 1-2 days until 
> the messages show up again.
> 
> The server has been running over 1 year without any problem, the problem 
> started show up around 2 weeks ago. It's running kernel 2.6.12, and 
> mysql server, nothing else. Hardware is Pentium 4 2.8GHz with 
> hyperthreading enabled.
> 
> What does the kernel message mean and why it make mysql stop accept new 
> connections? Is it hardware problem or try upgrade the kernel may help?
> Please CC me if possible. Thank you

The message means some code in the kernel or in some module passed a 
negative value to schedule_timeout which it shouldn't have. The c0284efd 
value is the address of the function that made the call - you may be 
able to look that up in your /proc/ksyms or the System.map file and 
figure out what function that is..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

