Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVCQCEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVCQCEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVCQCEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:04:02 -0500
Received: from sta.galis.org ([66.250.170.210]:28046 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S262968AbVCQCDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:03:09 -0500
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: georgalis@gmail.com,
  linux-kernel@vger.kernel.org,
  supervision@list.skarnet.org
Date: Wed, 16 Mar 2005 21:03:01 -0500
To: linux-kernel@vger.kernel.org, supervision@list.skarnet.org
Cc: georgalis@gmail.com
Subject: Re: a problem with linux 2.6.11 and sa
Message-ID: <20050317020301.GC3152@ixeon.local>
References: <20050303214023.GD1251@ixeon.local> <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2> <20050303224616.GA1428@ixeon.local> <871xaqb6o0.fsf@amaterasu.srvr.nix> <20050308165814.GA1936@ixeon.local> <871xap9dfg.fsf@amaterasu.srvr.nix> <20050309152958.GB4042@ixeon.local> <m3is40z9dy.fsf@multivac.cwru.edu> <20050316031814.GB1315@ixeon.local> <m3r7if6wte.fsf@multivac.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r7if6wte.fsf@multivac.cwru.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 05:37:59PM -0500, Paul Jarc wrote:
>"George Georgalis" <george@galis.org> wrote:
>> On Wed, Mar 09, 2005 at 06:28:35PM -0500, Paul Jarc wrote:
>>> To simplify, what about these two:
>>> mplayer foo.mpg
>>> mplayer foo.mpg < mediafiles.txt
>>
>> The particular host does not have X support so mpg is out.
>
>Well, use any one of the files listed in mediafiles.txt.  I expect the
>first one would behave the same as your for loop, and the second would
>behave the same as your while loop.

zz.mtest contains the full path to 3 ogg files on 3 lines, no funny
characters, the following is one of them.

$ mplayer /usr/nfs/sandbox/media/audio/_the-party-has-just-begun/Lebanese_Blonde.ogg

plays fine, as expected. however, per your test:

$ mplayer /usr/nfs/sandbox/media/audio/_the-party-has-just-begun/Lebanese_Blonde.ogg <zz.mtest 
MPlayer 1.0pre6-2.95.4 (C) 2000-2004 MPlayer Team
CPU: IDT/Centaur/VIA C3 Nehemiah (Family: 6, Stepping: 5)
Detected cache-line size is 32 bytes
CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 0
Compiled for x86 CPU with extensions: MMX MMX2 SSE


Playing /usr/nfs/sandbox/media/audio/_the-party-has-just-begun/Lebanese_Blonde.ogg.
Ogg file format detected.
==========================================================================
Opening audio decoder: [libvorbis] Ogg/Vorbis audio decoder
AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 14001->176400 (112.0 kbit)
Selected audio codec: [vorbis] afm:libvorbis (OggVorbis Audio Decoder)
==========================================================================
Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
AO: [oss] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
Video: no video
Starting playback...
No bind found for key _                                                         
A:   0.1 (00.1) ??,?%                                                           
No bind found for key L                         
No bind found for key _                         
No bind found for key B                         
No bind found for key l                         
A:   0.8 (00.8)  4.3%                                                           
  =====  PAUSE  =====

Exiting... (End of file)


program crashes quickly, without any keyboard interaction.

>> I'm not sure that that test would work as mplayer requires filenames
>> as command arguments not stdin (exclusivly, I think);
>
>Note that I said to redirect input from mediafiles.txt, not from any
>of the filenames listed in it, but one of the files listed in it
>should also be passed ion the command line in both cases.
>
>Your test also had mplayer's stdin connected to mediafiles.txt.  It
>was just less explicit - mplayer inherits stdin from surrounding loop.
>So I'm suggesting simplifying the test so that stdin is the *only*
>difference between the two cases, and that will show whether it's
>relevant.  OTOH, if you can't reproduce the problem with the
>simplified pair of tests, then some interaction with the shell loops
>must be involved.

per above, the problem is reproduced with your example.

v>> this works fine
>> mplayer `cat zz.mtest `
>
>> Then I tried
>> while read file; do mplayer "$file" ; done <zz.mtest
>
>What's in zz.mtest?  E.g., if it contains a line "-", then that will
>tell mplayer to play the file on stdin, which in this case is
>zz.mtest.  Choosing one of the listed files and testing with that, as
>I suggested above, will eliminate this possibility.

zz.mtest is just 3 ogg files like the one above in my first run. Me
throws up hands, I know it is kernel api change, me thinks Linux is not
posix anymore (per lkml followup). Big concern is not my ability to play
songs, but *complex* scripts to check spam during smtp are broke in
2.6.11 (rc?) and forward.

tmp="${scq}/`safecat "${scq}/tmp" "${scq}" </dev/stdin`" \
        || { echo "Error $?"; exit 71; } # put the pipeline to disk, if possible
        # ${scq}/tmp is a temp for this function ${scq} is temp for this program
score=`spamc -x -c <"$tmp"` # score it with spamd
sce=$?

... Who knows what else won't be working.

// George


-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
