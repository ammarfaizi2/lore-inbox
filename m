Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287846AbSABQqr>; Wed, 2 Jan 2002 11:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSABQqi>; Wed, 2 Jan 2002 11:46:38 -0500
Received: from cygnus.equallogic.com ([65.170.102.10]:60939 "HELO
	cygnus.equallogic.com") by vger.kernel.org with SMTP
	id <S287846AbSABQqU>; Wed, 2 Jan 2002 11:46:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.14641.376638.856274@pkoning.dev.equallogic.com>
Date: Wed, 2 Jan 2002 11:45:37 -0500 (EST)
From: Paul Koning <pkoning@equallogic.com>
To: jakub@redhat.com
Cc: trini@kernel.crashing.org, velco@fadata.bg, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
	<20020102153920.GA1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102165013.A1602@sunsite.ms.mff.cuni.cz>
X-Mailer: VM 6.75 under 21.1 (patch 11) "Carlsbad Caverns" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jakub" == Jakub Jelinek <jakub@redhat.com> writes:

 Jakub> On Wed, Jan 02, 2002 at 08:39:20AM -0700, Tom Rini wrote:
 >> Well, Paulus wrote 'strcpy' not 'memcpy', so why does gcc get to
 >> assume it's safe to change it?  In this case it's certainly not.

 Jakub> But unless you trigger undefined behaviour, strcpy(x, "foobar"
 Jakub> + n) is equal to memcpy(x, "foobar" + n, sizeof("foobar") -
 Jakub> n); and the latter is more efficient (you don't have to check
 Jakub> for end-of-string during copying).

I'd say it's the same even if you DO trigger undefined behavior.

"Undefined" means "anything can happen, don't blame the compiler".  In
particular, different things may happen at different times, under
different compilers, under different phases of the moon, etc...

The change from strcpy to memcpy either replaces a defined action by
the equivalent one, or replaces an undefined action by an undefined
action.  In the undefined case, the outcome may be different after the
change, but that's perfectly ok, that's what "undefined" means.

It might be interesting for the compiler to warn about this coding
error (since it presumably can detect it).  But "fixing" the behavior
of undefined code seems like a strange thing to do.

     paul

