Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282115AbRK1XEh>; Wed, 28 Nov 2001 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282155AbRK1XE1>; Wed, 28 Nov 2001 18:04:27 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:38203
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S282115AbRK1XEU>; Wed, 28 Nov 2001 18:04:20 -0500
Message-ID: <3C056D6D.5080201@switchmanagement.com>
Date: Wed, 28 Nov 2001 15:04:13 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: Hp82xxx external cd writer!
In-Reply-To: <EXCH01SMTP01mlm1DTv00003128@smtp.netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Maria Godinho de Matos wrote:

>I guys, i am not being able to put my externel hp to work!!!
>
>I have compiled the new 2.4.16 kernel and made sure i selected scsi support 
>and the specific hp82xxx suport from the text box in menuconfig!
>
>But i have no clue how to put my cd writer to work under linux, at least to 
>work as a cd-rom!!!!
>
>can any of u give a clue where to read something about it ( linux doc has got 
>NOTHING ), or even explain me slowly :P how to put it to work?
>
I don't know if the hp82xxxx is an IDE or SCSI model, but you might want 
to make sure ide-scsi support is compiled in or loaded as a module. 
 This was required for us to use cdrecord with an IDE cd writer.  If you 
are sure it is a SCSI cd writer, ignore the ide-scsi advice.  As far as 
actually burning a CD, we do something like the following:

mkisofs \
    -translation-table \
    -joliet \
    -rational-rock \
    -o CD-IMAGE-NAME.iso \
    DIRECTORY-CONTAINING-WHAT-YOU-WANT-TO-WRITE

cdrecord -eject -v speed=4 -isosize CD-IMAGE-NAME.iso dev=3,3,0

You will need to change the dev=x,y,z to something appropriate, the 
syntax is scsibus,target,lun.  Try cdrecord -scanbus to find the proper 
values.  Also change the speed=4 to something appropriate for your cd 
writer.  There are probably gui tools which will allow you to do this 
easier, but I am not familiar with them (search google or freshmeat.net 
or the KDE or Gnome sites).

Regards,
Brian Strand


