Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTGKN63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbTGKN63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:58:29 -0400
Received: from oak.sktc.net ([64.71.97.14]:2224 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S262321AbTGKN62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:58:28 -0400
Message-ID: <3F0EC5EF.7090002@sktc.net>
Date: Fri, 11 Jul 2003 09:13:03 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hzhong@cisco.com
CC: "'Alan Stern'" <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
References: <01c701c34766$4706cc50$743147ab@amer.cisco.com>
In-Reply-To: <01c701c34766$4706cc50$743147ab@amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

> Not always true. In some cases you know how to handle: just return
> without doing anyting.

That is NOT an error condition - the API specifically allows NULL to be 
passed in, and specifically states that no action will be taken in that 
case.

But consider the following code:

sscanf(0,0);


That IS an error condition - both the string to scan and the format 
string are NULL. In this case sscanf should return EITHER 0 (no items 
matched) or better still -1 (error).

As others have said - ideally, if you have any doubt about a new 
function you are writing being able to succeed, you should write it to 
return a success report.

However, my whole point was that simply checking for null and doing 
nothing when null was not a valid value was violating the rule of "don't 
check if you don't know how to handle".

