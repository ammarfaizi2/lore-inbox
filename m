Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVJAVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVJAVqE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVJAVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:46:04 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:39064 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750869AbVJAVqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:46:02 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jean Delvare <khali@linux-fr.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [HWMON] kmalloc + memset -> kzalloc conversion
Date: Sun, 02 Oct 2005 07:45:36 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <ln0uj11mbrnrrah1amu53dmno6bprf560g@4ax.com>
References: <20051001072630.GJ25424@plexity.net> <20051001224604.484ef912.khali@linux-fr.org>
In-Reply-To: <20051001224604.484ef912.khali@linux-fr.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2005 22:46:04 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Deepak,
>
>> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
>> 
>> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
>> --- a/drivers/hwmon/adm1021.c
>> +++ b/drivers/hwmon/adm1021.c
>> @@ -204,11 +204,10 @@ static int adm1021_detect(struct i2c_ada
>>  	   client structure, even though we cannot fill it completely yet.
>>  	   But it allows us to access adm1021_{read,write}_value. */
>>  
>> -	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
>> +	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {

	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {

instead?  Though lkml opinion seems to be split...

Cheers,
Grant.

