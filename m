Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTD3Ge1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbTD3Ge1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:34:27 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:31760 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262099AbTD3GeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:34:21 -0400
Message-ID: <3EAF72B0.5040605@kolumbus.fi>
Date: Wed, 30 Apr 2003 09:52:32 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Dave Peterson <dsp@llnl.gov>, linux-kernel@vger.kernel.org
Subject: Re: possible race condition in vfs code
References: <200304150922.07003.dsp@llnl.gov> <3EAF01FE.2040600@kolumbus.fi> <20030429230316.GR10374@parcelfarce.linux.theplanet.co.uk>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 30.04.2003 09:47:41,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 30.04.2003 09:47:17,
	Serialize complete at 30.04.2003 09:47:17
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I mean busy inodes after umount doing bogus write_inode_now. Busy inodes 
don't pin the superblock (vfsmnt does but it's gone, otherwise we 
wouldn't be in kill_sb in the first place).

Dave Peterson's fix solves the double free issue, but does potentially 
introduce another busy inode after sb has gone.

--Mika



viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Wed, Apr 30, 2003 at 01:51:42AM +0300, Mika Penttilä wrote:
>  
>
>>That piece of code looks wrong in other ways also..if we have unmounted 
>>an active fs (which shouldn't be done but happens!) we shouldn't be at 
>>least writing back to it anything! The !sb test isn't useful (we never 
>>clear it in live inodes) and MS_ACTIVE handling is racy as hell wrt 
>>umount...
>>    
>>
>
>Would you mind actually _reading_ kill_super() and stuff called by it?
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


