Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUAOWe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUAOWe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:34:58 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:51547 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262458AbUAOWew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:34:52 -0500
Message-ID: <40071589.3070409@sbcglobal.net>
Date: Thu, 15 Jan 2004 16:34:49 -0600
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanders <linux@sandersweb.net>
CC: Haakon Riiser <haakon.riiser@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NTFS disk usage on Linux 2.6
References: <20040115010210.GA570@s.chello.no> <200401151401.1764@sandersweb.net>
In-Reply-To: <200401151401.1764@sandersweb.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same issue on 2.6.0, this is with an 8.4G partition.

|sprchkn@rybBIT:~> df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hde1              49G   24G   25G  49% /
/dev/hde2             8.4G  3.2G  5.2G  38% /windows/h

sprchkn@rybBIT:/windows/h> du -sh *
773k    8cf3326dc751d489417f4d3be3
0       AUTOEXEC.BAT
0       CONFIG.SYS
71M     Documents and Settings
0       IO.SYS
0       MSDOS.SYS
48k     NTDETECT.COM
105M    Photoshop 6.0
90M     Program Files
0       RECYCLER
129G    System Volume Information
18G     WINDOWS
1.7M    WUTemp
0       boot.ini
476k    cmr2.0
123M    drivers
232k    ntldr
576M    pagefile.sys
250M    service
sprchkn@rybBIT:/windows/h> du -sh
148G    .|

Descending into the WINDOWS directory reports these folders incorrectly:
|3.3G    $NtUninstallKB826939$
3.3G    $NtUninstallKB826942$
3.4G    $NtUninstallQ327979$
3.1G    $NtUninstallQ814995$
3.7G    system32|

It shows WINDOWS/system32/dllcache to be 3.4GB.  There are 1371 files in 
this directory.

|sprchkn@rybBIT:/windows/h/windows/system32/dllcache> du -sh * | grep "M"
8.0k    IMS.CAT
152k    MAPIMIG.CAT
2.2M    MSHTML.DLL
20k     MW770.CAT
8.0k    OEMBIOS.CAT
340k    URLMON.DLL
1.1M    chsbrkr.dll
8.6M    hwxcht.dll
11M     hwxjpn.dll
8.6M    hwxkor.dll
1.1M    korwbrkr.lex
1.4M    luna.mst
2.2M    moviemk.exe
1.6M    msgr3en.dll
1.2M    msir3jp.lex
1.2M    msoeres.dll
2.9M    nls302en.lex
13M     oembios.bin
1.2M    quartz.dll
1.6M    sam.spd
3.2M    tourP.exe|

I didn't get anything with 'du -sh * | grep "G"', so it seems to be 
getting the correct size for each file but munges up the total somehow.

I though initially maybe it was related to the number of files in a 
directory, but that doesn't seem to be the case:

|sprchkn@rybBIT:/windows/h/windows/$NtUninstallKB826939$> du * -sh
80k     accwiz.exe
416k    crypt32.dll
40k     cryptsvc.dll
8.0k    hh.exe
376k    hhctrl.ocx
24k     hhsetup.dll
96k     itss.dll
48k     magnify.exe
116k    migwiz.exe
32k     narrator.exe
124k    newdev.dll
460k    ntdll.dll
124k    osk.exe
68k     pchshell.dll
36k     raspptp.sys
4.0k    reg00010
4.0k    reg00011
4.0k    reg00012
4.0k    reg00013
4.0k    reg00018
4.0k    reg00019
4.0k    reg00020
4.0k    reg00021
4.0k    reg00022
4.0k    reg00023
4.0k    reg00026
4.0k    reg00027
4.0k    reg00028
4.0k    reg00029
4.0k    reg00034
4.0k    reg00035
4.0k    reg00042
4.0k    reg00043
4.0k    reg00044
4.0k    reg00045
4.0k    reg00046
4.0k    reg00047
4.0k    reg00069
4.8M    shell32.dll
104k    spuninst
148k    srrstr.dll
216k    zipfldr.dll
sprchkn@rybBIT:/windows/h/windows/$NtUninstallKB826939$> du -sh
3.3G    .|

-Wes-

David Sanders wrote:

>On Wednesday 14 January 2004 08:02 pm, Haakon Riiser wrote:
>  
>
>>Has anyone else noticed that the reported disk space usage on
>>NTFS is completely unreliable on Linux 2.6?  Just issued the
>>    
>>
>
>I'm having the same symptom.  The following is on a 4G partition.  The 
>WINNT directory is reported as 66G in size.  Kernel 2.6.1.
>
>david@debian:/mnt/hda5$ du * -sh
>124M    file
>56M     GNUwin32
>6.3M    Inetpub
>1.3M    lynx
>0       Multimedia Files
>267M    pagefile.sys
>134M    perl
>922M    Program Files
>0       RECYCLER
>42M     TEMP
>2.7M    util
>13M     vim
>2.5k    _viminfo
>66G     WINNT
>
>
>  
>
