Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTIMHfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTIMHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:35:10 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:24967 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S262072AbTIMHfD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:35:03 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
       =?ISO-8859-1?Q?=20S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Impossible to read files from a CD-Rom
In-Reply-To: <20030912065116.GA16813@suse.de> (Jens Axboe's message of "Fri,
 12 Sep 2003 08:51:16 +0200")
References: <20030818163520.GA413@galois>
	<20030908152800.GA5224@bouh.famille.thibault.fr>
	<20030912065116.GA16813@suse.de>
From: Daniel Pittman <daniel@rimspace.net>
Date: Sat, 13 Sep 2003 17:34:57 +1000
Message-ID: <87he3h87ku.fsf@enki.rimspace.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (cassava, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Jens Axboe wrote:
> On Mon, Sep 08 2003, Samuel Thibault wrote:
>> On Mon 18 aug 2003 18:35:22 GMT, Sébastien Hinderer wrote:
>> > I'm using a vanila linux-2.6.0-test3. When I try to use a CD-Rom,
>> > the mount is successful, so are the calls to ls. However, as soon
>> > as I try to read a file, I get a lot of messages such as :

[...]

>> We dug a little bit this Monday with Sebastien, and found out some
>> troubles: the call to set_capacity at the end of cdrom_read_toc()
>> writes a strange value, which is not always the same, even for the
>> same reinserted CD-ROM, seemingly because it came from
>> cdrom_get_last_written():

[...]

> I'd be more interested in fixing the real bug: why does your drive
> return zero length, and only sporadically?

This sounds somewhat like a problem I have playing DVD-R discs on one
DVD drive (Pioneer slot-loader), using Xine and the RAW device.

Basically, for some discs, the raw device cannot read any block, as the
capacity of the disc is reported as zero blocks.

I don't have trouble accessing the content on any other machine, though,
and can access the files through a mounted filesystem.

/proc/ide/hdc/capacity contains zero in these cases.

Occasionally, for a disc that does this, I get a valid (looking) size,
but not very often -- one time in twenty, at most.

I am happy to work on debugging this, if there is anything that can be
done to help identify the problem.

This only seems to occur with DVD-R discs, and without any predictable
pattern.

        Daniel

-- 
Gratitude is one of the least articulate of the emotions, 
especially when it is deep.
        -- Felix Frankfurter
