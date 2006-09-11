Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWIKJkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWIKJkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIKJkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:40:05 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:20497 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932155AbWIKJkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:40:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A5pjC37SVkBAxprTIkM21Y0wu3DxiLxm6DZNYCHgf8I7Bnbw8+fmW6aTOtVGTX4IRGOp53lFnurUpXzvZSs/uz2pxpJaJjCUHVldcNOurCeISWZI+aqKl5LvhqoKfr4bZMVCasgfvhNG34gw6PUZqiRmWlPaavAZAbo7SFgr250=
Message-ID: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
Date: Mon, 11 Sep 2006 04:40:03 -0500
From: "Travis H." <solinym@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: design of screen-locks for text-mode sessions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy!

This may diverge away from kernelspace, and if so I'll take the discussion
off-list with interested parties.  In the meantime, I was wondering what people
thought about the best design for locking text-mode console sessions.  It's a
checkbox on some regulatory compliance list, I think for the PCI specs (that's
credit cards, not the bus) and I'm sort of surprised there isn't an easy-to-find
package for this.

If you think this belongs somewhere else, please recommend the location
to me.  One public response will be sufficient to let me know this is
inappropriate.
I know all the solutions might not be in kernelspace, but there are
some system-level interactions that require a deeper understanding of
kernel tty handling and login sequence than most lists can offer.

I'm thinking that the easiest solution might be an expect script that
sits between
mingetty and login, so it can learn the username and password, and later on
has a timeout that stops passing data to the spawned login/shell.  However,
what I worry about is the vagaries of signal handling and other tricks that
might be required to ensure that this solution isn't bypassed.  It
also is somewhat
unfriendly to non-conventional login methods (I assume there are many options
with PAM other than username/password).

Am I correct in assuming that login execs the shell, as opposed to
hanging around
after authentication?

To my mind, the solution would have these requirements:
Can detect keyboard inactivity in that console more than a configurable minimum.
Can't be bypassed.
Can require re-authentication after the inactivity timeout.

Nice-to-have:
Works with any authentication method.
Portable.
Userspace > LKM > kernel recompile
Few changes to a stock RHEL install required to make it happen.
-- 
"If you're not part of the solution, you're part of the precipitate."
Unix "guru" for rent or hire -><- http://www.lightconsulting.com/~travis/
GPG fingerprint: 9D3F 395A DAC5 5CCC 9066  151D 0A6B 4098 0C55 1484
