Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbTC2UC6>; Sat, 29 Mar 2003 15:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbTC2UC6>; Sat, 29 Mar 2003 15:02:58 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:62369 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S263456AbTC2UC5>;
	Sat, 29 Mar 2003 15:02:57 -0500
Date: Sat, 29 Mar 2003 20:14:13 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: john@grabjohn.com, =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
Message-ID: <1995917808.1048968853@[192.168.100.5]>
In-Reply-To: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
References: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 29 March 2003 18:29 +0000 john@grabjohn.com wrote:

>> this patch un-complicates a small piece of code of the dev/pts
>> filesystem and decreases the size of the object code by 8 bytes
>> for my build. Yay! :)
>
>> -		err = PTR_ERR(devpts_mnt);
>> -		if (!IS_ERR(devpts_mnt))
>> -			err = 0;
>> +		if (IS_ERR(devpts_mnt))
>> +			err = PTR_ERR(devpts_mnt);
>
> Why not use
>
> err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));

Perhaps because it inverts the logic, and has a superfluous
assignment causing a warning? :-) I think you meant:

  err = IS_ERR(devpts_mnt) ? PTR_ERR(devpts_mnt) : 0;

--
Alex Bligh
