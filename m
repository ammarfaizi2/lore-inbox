Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWC3Xe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWC3Xe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWC3Xe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:34:28 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:55467 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751151AbWC3Xe1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:34:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uKZql+5r9sh74Zf8w++xaC4MaRQzGHkdBiHC8oDqRj42ErEzmcJOTIVXY3oVLG3VA3LGGvSfROX5Pmii7CQWxMZIcMbHcNU71ov+9mI8pBhSO3ClOq59KiHJ4JXt7Rje/7Fu1BrlY4nqSwP1VlELVF/kew4XIdkDo+Lb67VBiPQ=
Message-ID: <355e5e5e0603301534g2a00e65aqdb57e340578b33d1@mail.gmail.com>
Date: Thu, 30 Mar 2006 18:34:26 -0500
From: "Lukasz Kosewski" <lkosewsk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Status of promise sata hotplug patches? (works great!)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Philip,

(re-send due to the list ignoring my UTF-8 charset)

On 3/15/06, Philip Langdale <philipl@mail.utexas.edu> wrote:
> I recently dug up your promise sata hotplug patches
> and have been successfully using them with a SATA300 TX4
> card (I had to modify the patch to identify this card as
> hotplug capable, but it's all the same as the SATAII150).

So contrary to popular belief, I'm not dead, just in the middle of
final exams.  Thankfully, this is the last time anyone will have to
deal with such a delay, since if all goes well I'll be getting my
Bachelor's degree at the end of April.

Feel free to send me the modification you made; I won't be able to
test it since I don't have a SATA300 TX4 card, but I can integrate it
into what I've got.

> I also had to make very minor changes to get the patches
> to apply to 2.6.16-rc6, but they work great - so I was
> wondering what the situation was with respect to getting
> them merged in?

OK, it's sweet that things are working with 2.6.16.  I keep meaning to
port my patches forward, but never really have the time.  Soon I will.
 With respect to merging into mainline, the current stumbling block is
Tejun Heo's EH layer changes, which are really sane but their
completion is still just around the corner.  Currently, the big issue
with hotplug stuff is that it isn't synchronizing with libata at all,
so the suspicion is that if the controller is in the middle of doing
some PIO operation or something and the drive gets unplugged, things
would be bad.  Perhaps this can be viewed as an 'edge case,' but I
think it's important to keep things synchronized.

So, when I get a chance, I will start looking at all the EH changes,
and make hotplug play well with those.  By that, I mean that rather
than bypassing libata EH completely and just calling SCSI plug/unplug
routines, resetting the bus., etc, what I will try to do is integrate
the two.  For instance; I get an interrupt saying 'the disk is gone',
and then ask EH "is the disk REALLY gone, or was this a cable blip?"
EH then tells me and some action (or none) occurs.

This still has some ways to go, but it's not in some unforseeable
future, it just depends on when I'll have time to hack on this.
Currently, it's looking like come the end of June (at the earliest) I
can get back to hacking on it, assuming I've got a job condusive to my
doing lots of kernel hacking at the time.

Sorry that I can't say anything terribly exciting like "tomorrow," but
it's just not time-feasible at the moment.  Thanks for inquiring about
the project status though, with the positive feedback this is getting,
it at least means things are on the right path.

Luke Kosewski
