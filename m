Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFXOyW>; Mon, 24 Jun 2002 10:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSFXOyV>; Mon, 24 Jun 2002 10:54:21 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:33763 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313711AbSFXOyU>; Mon, 24 Jun 2002 10:54:20 -0400
Message-ID: <3D17324F.10705@antefacto.com>
Date: Mon, 24 Jun 2002 15:53:03 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Lightweight patch manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] quotemarks and trailing whitespaces (1st, revisited)
References: <Pine.LNX.4.44.0206121520480.30784-100000@hawkeye.luckynet.adm> <20020623115039.GA2799@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------010000060809040408040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000060809040408040306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>I redid the quotemark patch. Since I'm a lazy typist, I had a script which
>>removed all whitespaces before virtual or real newline characters. Does
>>this one look OK to you?
> 
> 
> Perhaps such patch should go to scripts/ in distribution, so when
> someone finishes big cleanup for driver can run it at the same time?
> 									Pavel

This thread is probably of interest.
http://marc.theaimsgroup.com/?l=linux-kernel&m=100653615123970&w=2
It was just when 2.5.0 came out since I thought it was the
most appropriate time for something like this.
Anyway the simple script I used is attached.
Note for 2.5.0 it removed 224,654 bytes.

Padraig.

--------------010000060809040408040306
Content-Type: text/plain;
 name="rmws"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rmws"

#!/bin/sh
# Remove trailing whitespace. By default it runs
# in the current directry, on all files, but you 
# can change this by passing parameters as you 
# would to find.
#
# Note this doesn't change file (timestamps)
# which don't need to be updated.

#Note super sed has a -i option to do this (edit files in place)
#also perl can edit files in place easily.

# Temporary file
temp=/tmp/runsed$$

find "$@" -type f -print |
while read file
do
    echo -n "editing $file: "
    if test -s $file; then
       sed -e 's/[ 	]*$//g' <$file > $temp
       if test -s $temp; then
           if cmp -s $file $temp; then
             echo -n "file not changed: "
           else
             cp $temp $file
           fi
           echo "done"
       else
           echo "produced an empty file - aborting"
       fi
    else
       echo "original file is empty."
    fi
done
echo "all done"
rm -f $temp


--------------010000060809040408040306--

