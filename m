Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIUPoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIUPoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUIUPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:44:30 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37297 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267769AbUIUPoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:44:14 -0400
Message-ID: <41504C21.3090506@nortelnetworks.com>
Date: Tue, 21 Sep 2004 09:43:29 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] inotify 0.9.2
References: <1095652572.23128.2.camel@vertex>	<1095744091.2454.56.camel@localhost> <20040921173404.0b8795c9.froese@gmx.de>
In-Reply-To: <20040921173404.0b8795c9.froese@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
> Robert Love wrote:
> 
>> struct inotify_event {
>> 	int wd;
>> 	int mask;
>>-	char filename[256];
>>+	char filename[PATH_MAX];
>> };
> 
> 
> You really want to shove >4kB per event to userspace???

Ouch.

Maybe make it variable-size?  On average it would likely be shorter.

struct inotify_event {
	int wd;
	int mask;
	short namelen;
	char filename[0];
};

Chris
