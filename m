Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWHASId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWHASId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWHASId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:08:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32952 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750980AbWHASIc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:08:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] i386: Relocatable kernel support.
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302351934-git-send-email-ebiederm@xmission.com>
	<44CF5850.80906@kolumbus.fi>
Date: Tue, 01 Aug 2006 12:07:02 -0600
In-Reply-To: <44CF5850.80906@kolumbus.fi> (Mika =?iso-8859-1?Q?Penttil=E4'?=
 =?iso-8859-1?Q?s?= message of "Tue, 01
	Aug 2006 16:34:08 +0300")
Message-ID: <m1y7u8xrcp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Penttilä <mika.penttila@kolumbus.fi> writes:

>> @@ -1,9 +1,10 @@
>>  SECTIONS
>>  {
>> -  .data : { +  .data.compressed : {
>>  	input_len = .;
>>  	LONG(input_data_end - input_data) input_data = .;  	*(.data)
>> +	output_len = . - 4;
>>  	input_data_end = .;  	}
>>  }
>>
> I don't see how you are getting the uncompressed length from output_len...

It's part of the gzip format.  It places the length at the end of
the compressed data.  I am just computing the address of where gzip
put the length and putting a variable there called output_len.

Isn't linker script magic wonderful :)

Eric
