Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289620AbSAJTNu>; Thu, 10 Jan 2002 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289611AbSAJTNe>; Thu, 10 Jan 2002 14:13:34 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:5023
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289612AbSAJTNU>; Thu, 10 Jan 2002 14:13:20 -0500
Message-Id: <200201101858.g0AIw7A18958@snark.thyrsus.com>
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Intelligible build progress
Date: Thu, 10 Jan 2002 06:11:20 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W2ZPP27OUZ3HC19PORO3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_W2ZPP27OUZ3HC19PORO3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

I got bored.  I wrote a toy.  It's an output filter you pipe a build into 
that actually explains what's going on.  It cuts the output down enough that 
you can actually see warnings (wow!), but not so much you don't know what 
it's doing or have some kind of progress indicator.

It's evil, it's nasty, it's ugly, it's vicious.  It currently requires python 
2.x (because I intend to put a curses front end on it, that's why).  But it 
also seems to be working, so I'm releasing what I've got so far under the GPL 
so people can flame me now and avoid the rush. :)

At the moment, you just copy "blueberry.py" onto your system (the "scripts" 
directory makes sense) and then use it like this (cut and paste and you've 
got a shell script):

### Start of script

# "Entering directory" messages are just clutter in make dep

make dep | scripts/blueberry.py e

# This is short enough we don't need to see progress

echo "Cleaning out old temporary files."
echo " "
make clean > /dev/null

# Okay, build.

make bzImage | scripts/blueberry.py
make modules | scripts/blueberry.py

# make install/modules install require root access, not handling this yet.

### End of script

As I said, later I want to make it part of a curses front-end showing you 
what directory you're currently in, what action is being taken, and with 
stderr (warnings, etc) scrolling by in its own little box.  Oh, and not 
having to run make dep and make clean all the time would be nice too, but 
that waits on Kieth Owens' new makefiles.

Yeah it's a big evil mess of heuristics.  I know.  And the above script will 
still try to build modules if bzImage bombs with an error.  And you've got to 
ctrl-c twice to kill it...

I've tested it (if you can use that word) against 2.4.17, I don't know if 
there's new stuff in 2.5 it can't deal with yet.  (Shouldn't be, but...)

Here's the file.

You may cringe now.
--------------Boundary-00=_W2ZPP27OUZ3HC19PORO3
Content-Type: application/x-python;
  name="blueberry.py"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blueberry.py"

IyEvdXNyL2Jpbi9weXRob24yCgojIEtlcm5lbCBidWlsZCBjbGVhbmVyIHZlcnNpb24gMC4wMDAw
MDAwMDAwMSwgb3IgbGVzcy4KIyBDb3B5cmlnaHQgMjAwMiBSb2IgTGFuZGxleQojIFJlbGVhc2Vk
IHVuZGVyIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgb3IgaGlnaGVy
LAojICh0aGUgR1BMIGlzIGF2YWlsYWJsZSBmcm9tIHd3dy5nbnUub3JnL2NvcHlsZWZ0L2dwbC5o
dG1sKQoKaW1wb3J0IHN5cywgc3RyaW5nCgpub2VudGVyPTAKCmRlZiBtYW5nbGUoaW5wdXQsIG91
dHB1dCk6CgogIGRpcj0iLiIKICBzaHV0dXA9MAogIGxlZnRvdmVycz1Ob25lCgogICMgUmVwZWF0
IHVudGlsIHNwYW5rZWQ6CgogIHdoaWxlIDE6CiAgICByZXN1bHQ9Tm9uZQogICAgbGluZT1pbnB1
dC5yZWFkbGluZSgpCiAgICBpZiBub3QgbGluZTogYnJlYWsKICAgIGlmIHNodXR1cDoKICAgICAg
b3V0cHV0LndyaXRlKCIuXG4iKQogICAgICBjb250aW51ZQoKICAgICMgUmVhc3NlbWJsZSBzcGxp
dCBsaW5lcwoKICAgIGlmIGxlZnRvdmVyczoKICAgICAgbGluZT0iJXMgJXMiICUgKGxlZnRvdmVy
cyxsaW5lKQogICAgd29yZHM9bGluZS5zcGxpdCgpCiAgICBpZiB3b3Jkc1stMV09PSdcXCc6CiAg
ICAgIGxlZnRvdmVycz1saW5lCiAgICAgIGNvbnRpbnVlCiAgICBlbHNlOiBsZWZ0b3ZlcnM9Tm9u
ZQoKICAgICMgU3R1ZmYgdG8ganVzdCBjb21wbGV0ZWx5IHNraXA6CgogICAgIyAgIG1ha2U6IFdo
ZW4gb25lIG1ha2UgZmlsZSBjYWxscyBhbm90aGVyLCBpdCBhbm5vdW5jZXMgdGhlIGZhY3QuCiAg
ICAjICAgcm06IEJ1aWxkIGV4cGxpY2l0bHkgZGVsZXRlcyBvbGQgLm8gZmlsZSBiZWZvcmUgY2Fs
bGluZyBsaW5rZXIgKGxkKQoKICAgIGlmIHdvcmRzWzBdIGluICgibWFrZSIsICJybSIpOiBjb250
aW51ZQoKICAgIGlmIHdvcmRzWzBdPT0iZ2NjIjoKICAgICAgaWYgd29yZHNbLTFdLmVuZHN3aXRo
KCIuYyIpOgogICAgICAgIHJlc3VsdD0iQ29tcGlsaW5nICVzLyVzIiAlIChkaXIsd29yZHNbLTFd
KQogICAgICBlbHNlOgogICAgICAgIGZvciBpIGluIHJhbmdlKGxlbih3b3JkcykpOgogICAgICAg
ICAgaWYgd29yZHNbaV0uZW5kc3dpdGgoIi5TIik6CiAgICAgICAgICAgIHJlc3VsdD0iUHJlcHJv
Y2Vzc2luZyAlcy8lcyIgJSAoZGlyLHdvcmRzW2ldKQogICAgICAgICAgICBicmVhawogICAgZWxp
ZiB3b3Jkc1swXT09ImxkIjoKICAgICAgZm9yIGkgaW4gcmFuZ2UobGVuKHdvcmRzKSk6CiAgICAg
ICAgaWYgd29yZHNbaV09PSItbyI6CiAgICAgICAgICByZXN1bHQ9IkxpbmtpbmcgJXMvJXMiICUg
KGRpcix3b3Jkc1tpKzFdKQogICAgICAgICAgYnJlYWsKICAgIGVsaWYgd29yZHNbMF09PSJhcyI6
CiAgICAgIHJlc3VsdD0iQXNzZW1ibGluZyAlcy8lcyIgJSAoZGlyLHdvcmRzWy0xXSkKICAgIGVs
aWYgd29yZHNbMF0uc3RhcnRzd2l0aCgibWFrZVsiKToKICAgICAgaWYgd29yZHNbMl09PSJkaXJl
Y3RvcnkiOgogICAgICAgIGlmIHdvcmRzWzFdPT0iRW50ZXJpbmciOgogICAgICAgICAgZGlyPXdv
cmRzWzNdWzE6LTFdCiAgICAgICAgICBpZiBub2VudGVyOiBjb250aW51ZQogICAgICAgICAgcmVz
dWx0PSJFbnRlcmluZyAlcyIgJSBkaXIKICAgICAgICBlbHNlOiBjb250aW51ZSAgIyBMZWF2aW5n
IGRpcmVjdG9yeSBpcyBub3QgaW50ZXJlc3RpbmcuCiAgICAgIGlmIHdvcmRzWzFdPT0iTm90aGlu
ZyI6IGNvbnRpbnVlICMgUG9pbnRsZXNzIGVycm9yIG1lc3NhZ2UKICAgIGVsaWYgd29yZHNbMF0u
ZW5kc3dpdGgoIi9ta2RlcCIpOgogICAgICByZXN1bHQ9IkZpbmRpbmcgZGVwZW5kZW5jaWVzIGlu
ICVzIiAlIGRpcgogICAgZWxpZiB3b3Jkc1swXT09Im5tIjoKICAgICAgcmVzdWx0PSJFeHRyYWN0
aW5nIHN5bWJvbHMgdG8gJXMiICUgd29yZHNbLTFdCiAgICBlbGlmIHdvcmRzWzBdLnN0YXJ0c3dp
dGgoInRtcHBpZ2d5PSIpOgogICAgICByZXN1bHQ9IkNyZWF0aW5nIGNvbXByZXNzZWQga2VybmVs
IGltYWdlIgogICAgICBzaHV0dXA9MQogICAgZWxpZiB3b3Jkc1swXT09ImFyIjogICMgU28gbGlu
a2VyIGRlcGVuZGVuY2llcyBkb24ndCBoYXZlIHRvIGNoYW5nZQogICAgICByZXN1bHQ9IkNyZWF0
aW5nIGVtcHR5IG9iamVjdCAlcyIgJSB3b3Jkc1syXQogICAgZWxpZiB3b3Jkc1swXT09InNoIiBv
ciB3b3Jkc1swXT09Jy4nIG9yIHdvcmRzWzBdLmZpbmQoIi8iKSE9LTE6CiAgICAgIGlmIHdvcmRz
WzBdPT0ic2giOgogICAgICAgIHdoaWxlIHdvcmRzWzFdLnN0YXJ0c3dpdGgoIi0iKTogd29yZHNb
MToyXT1bXQogICAgICAgIHdvcmRzWzA6MV09W10KICAgICAgaWYgd29yZHNbMF0uZmluZCgiLyIp
IT0tMToKICAgICAgICB3aGlsZSB3b3Jkc1swXS5zdGFydHN3aXRoKCIuLyIpOiB3b3Jkc1swXT13
b3Jkc1swXVsyOl0KICAgICAgICB0ZW1wPVsiUnVubmluZyAlcy8lcyIgJSAoZGlyLHdvcmRzWzBd
KV0KICAgICAgZWxzZTogdGVtcD1bIlJ1bm5pbmcgJXMiICUgd29yZHNbMF1dCiAgICAgIHRlbXAu
ZXh0ZW5kKHdvcmRzWzE6XSkKICAgICAgcmVzdWx0PSIgIi5qb2luKHRlbXApCgogICAgIyBUaGF0
J3MgYWxsIHdlIHVuZGVyc3RhbmQuICBOb3cgZG8gc29tZXRoaW5nIHdpdGggaXQuCgogICAgaWYg
bm90IHJlc3VsdDoKICAgICAgb3V0cHV0LndyaXRlKCJVbmtub3duIGxpbmU6ICVzXG4iICUgbGlu
ZSkKICAgIGVsc2U6CiAgICAgIG91dHB1dC53cml0ZShyZXN1bHQpCiAgICAgIGlmIG5vdCBzaHV0
dXA6IG91dHB1dC53cml0ZSgiXG4iKQoKZW5kb2ZsaW5lPSJcciIKaWYgbGVuKHN5cy5hcmd2KT4x
OgogIGlmIHN5cy5hcmd2WzFdLmZpbmQoIm4iKSE9LTE6IGVuZG9mbGluZT0iXG4iCiAgaWYgc3lz
LmFyZ3ZbMV0uZmluZCgiYyIpIT0tMTogc2hvd2NvdW50PTEKICBlbHNlOiBzaG93Y291bnQ9MAog
IGlmIHN5cy5hcmd2WzFdLmZpbmQoImUiKSE9LTE6IG5vZW50ZXI9MQoKbWFuZ2xlKHN5cy5zdGRp
biwgc3lzLnN0ZG91dCkKcHJpbnQKCgo=

--------------Boundary-00=_W2ZPP27OUZ3HC19PORO3--
