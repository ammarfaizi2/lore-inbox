Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVLZL6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVLZL6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 06:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLZL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 06:57:59 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:46274 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbVLZL57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 06:57:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=NjzEtUCP5VX5wrBqvaUD9ecR5RhJuxKnLM7nPqqn807sobvZvo0EINCQdKfbIfEw0WiQbMQUqNYgTeFeBHiOc0/YvzMgKjoTwEsKmXT4lq/tgy2pGZqbLNndwOLvazYDOBg42nbFChEDQgioPq0Pl/SUypYknvGNrf4j4s+RMwE=
Message-ID: <9611fa230512260357gcb3a163tae35f7e69f1ee7df@mail.gmail.com>
Date: Mon, 26 Dec 2005 11:57:57 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_21060_25903702.1135598277900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_21060_25903702.1135598277900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I'm having hard lockups with all the RCs of linux-2.6.15. I,
previously, mentioned this with the subject "[BUG]: Software compiling
occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2" in the
list. I investigated a bit at found these interesting things.

-- Always reproducable. To reproduce:
    - in console 1, issueing "updatedb"
    - in console 2, issueing "find / -name "blahblah" -print
    - in console 3, issueing "emerge -uDp world" (BTW, I'm using Gentoo.)
    - in console 4, X started.
    - a few minutes later, system completely freezes. No Alt+SysRq+t
works. (Normally, it does)

When the system freezes, there is nothing in logs. But hardly, I
captured an  Alt+SysRq+t. A few seconds (15-20 seconds) before hang. I
attached this  Alt+SysRq+t and lsmod output. Hope this helps to solve
this.

PS: These problems never occured in 2.6.14.xx and downwards.

Regards.

------=_Part_21060_25903702.1135598277900
Content-Type: application/octet-stream; name=lsmod.out
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lsmod.out"

Module                  Size  Used by
arc4                    2176  1 
pcmcia                 37024  4 
yenta_socket           25740  3 
rsrc_nonstatic         11904  1 yenta_socket
pcmcia_core            40480  3 pcmcia,yenta_socket,rsrc_nonstatic
rfcomm                 36372  0 
l2cap                  24448  5 rfcomm
snd_pcm_oss            47776  0 
snd_mixer_oss          17408  1 snd_pcm_oss
snd_seq_dummy           4100  0 
snd_seq_oss            30976  0 
snd_seq_midi_event      7296  1 snd_seq_oss
snd_seq                49168  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8972  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_intel8x0m          16908  1 
snd_intel8x0           31004  5 
snd_ac97_codec         83872  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            2688  1 snd_ac97_codec
snd_pcm                83460  6 snd_pcm_oss,snd_intel8x0m,snd_intel8x0,snd_ac97_codec
snd_timer              24068  4 snd_seq,snd_pcm
snd                    53348  18 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9696  1 snd
snd_page_alloc         10888  3 snd_intel8x0m,snd_intel8x0,snd_pcm
nls_utf8                2432  1 
ntfs                  192016  1 
ieee80211_crypt_tkip    10240  0 
ieee80211_crypt_ccmp     6912  0 
ieee80211_crypt_wep     4992  1 
ipw2100               129636  0 
ieee80211              41192  1 ipw2100
ieee80211_crypt         6276  4 ieee80211_crypt_tkip,ieee80211_crypt_ccmp,ieee80211_crypt_wep,ieee80211
firmware_class         10624  2 pcmcia,ipw2100
e100                   37124  0 
mii                     5760  1 e100
bluetooth              45156  4 rfcomm,l2cap
uhci_hcd               31120  0 
ehci_hcd               30984  0 
ohci_hcd               19844  0 
usb_storage            67392  0 
usbcore               119044  5 uhci_hcd,ehci_hcd,ohci_hcd,usb_storage
scsi_mod               93992  1 usb_storage
as_iosched             17796  2 
agpgart                32984  0 


------=_Part_21060_25903702.1135598277900
Content-Type: application/x-bzip2; name=trace.out.bz2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="trace.out.bz2"

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
pX8CfLoPIoh/8XckU4UJBwvWB5A=
------=_Part_21060_25903702.1135598277900--
