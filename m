Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVJBLJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVJBLJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJBLJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 07:09:39 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:53730 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751077AbVJBLJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 07:09:38 -0400
Message-ID: <433FBFF0.8060102@andrew.cmu.edu>
Date: Sun, 02 Oct 2005 07:09:36 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <433FAD57.7090106@yahoo.com.au> <433FBE59.8000806@superbug.co.uk>
In-Reply-To: <433FBE59.8000806@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Nick Piggin wrote:
>> Ahmad Reza Cheraghi wrote:
>>> Can somebody tell me why the Kernel-Development dont
>>> wanne have XML is being used in the Kernel??
>>
>> Because nobody has come up with a good reason why it
>> should be. Same as anything that isn't in the kernel.
>> Nick
>>
> I have a requirement to pass information from the kernel to user space. 
> The information is passed fairly rarely, but over time extra parameters 
> are added. At the moment we just use a struct, but that means that the 
> kernel and the userspace app have to both keep in step. If something 
> like XML was used, we could implement new parameters in the kernel, and 
> the user space could just ignore them, until the user space is upgraded.
> XML would initially seem a good idea for this, but are there any methods 
> currently used in the kernel that could handle these parameter changes 
> over time.

If you only add parameters, why not use a struct with a length field? 
That can encode version information implicitly; You can assume 
everything beyond the length is not present in that ABI version.  If the 
interface is based on read(2), then you don't even need the length field 
in the structure, since everything can be handled by userspace 
specifying the length it wants as the read size parameter, and the 
kernel returning only the bytes for the fields it knows about.
  - Jim Bruce

> For example, should the sysfs be used for this?
> Any comments?
> James
