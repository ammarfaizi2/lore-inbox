Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288231AbSAMWa1>; Sun, 13 Jan 2002 17:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288233AbSAMWaI>; Sun, 13 Jan 2002 17:30:08 -0500
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:4764 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288231AbSAMW36>; Sun, 13 Jan 2002 17:29:58 -0500
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Intelligible build process v0.02
Date: Sun, 13 Jan 2002 09:27:56 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_K6SVAZQXPCYEDFPFPDJ5"
Message-Id: <20020113222957.GKGI8076.femail23.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_K6SVAZQXPCYEDFPFPDJ5
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Here's v0.02 for those intrepid testers who want to see what their build is 
actually doing rather than watching a wall of mostly uninteresting text 
scroll by really fast.

With this script, you can actually spot the warnings.

The previous version got really confused by what "make dep" did in response 
to kernel module versions being switched on (but only after a fresh untar, or 
after running make mrproper).  I've now taught it more about the evils of 
make dep, so it's less confused, but I wouldn't call the cleaned up version 
of the output pretty...  (I'm not too worried: Kieth Owens' new build makes 
make dep go away completely.  I now know a lot more about why this is a good 
thing.)

Just throw the attached file in the scripts directory.  The script to test 
this still goes:

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

And it still requires python 2, but you cml2 testers should have no trouble 
with this. :)

I'm working on the curses frontend to replace the above script.  (The 
frontend is about  half the point of the exercise, cleaning up text mode is 
just a nice way to test it), but I've got paying work standing between me and 
that for a bit, so it'll be a few more days... :)

Rob
--------------Boundary-00=_K6SVAZQXPCYEDFPFPDJ5
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
bGluZyBsaW5rZXIgKGxkKQogICAgIyAgIG12LCB8OiBQcm9kdWNlZCBieSBtYWtlIGRlcCB3aXRo
IG1vZHZlcnNpb25zLiAgS2x1ZGdlLgoKICAgIGlmIHdvcmRzWzBdIGluICgibWFrZSIsICJybSIs
ICJ8IiwgIm12Iik6IGNvbnRpbnVlCgogICAgaWYgd29yZHNbMF09PSJnY2MiOgogICAgICBhY3Rp
b249Tm9uZQogICAgICBmb3IgaSBpbiByYW5nZShsZW4od29yZHMpKToKICAgICAgICBpZiB3b3Jk
c1tpXT09Ii1FIjogYWN0aW9uPSJQcmVwcm9jZXNzaW5nIgogICAgICAgIGVsaWYgd29yZHNbaV0u
ZW5kc3dpdGgoIi5jIik6CiAgICAgICAgICBpZiBub3QgYWN0aW9uOiBhY3Rpb249IkNvbXBpbGlu
ZyIKICAgICAgICAgIGZpbGU9d29yZHNbaV0KICAgICAgICBlbGlmIHdvcmRzW2ldLmVuZHN3aXRo
KCIuUyIpOgogICAgICAgICAgaWYgbm90IGFjdGlvbjogYWN0aW9uPSJBc3NlbWJsaW5nIgogICAg
ICAgICAgZmlsZT13b3Jkc1tpXQogICAgICBpZiBmaWxlOiByZXN1bHQ9IiVzICVzLyVzIiAlIChh
Y3Rpb24sZGlyLGZpbGUpCiAgICBlbGlmIHdvcmRzWzBdPT0ibGQiOgogICAgICBmb3IgaSBpbiBy
YW5nZShsZW4od29yZHMpKToKICAgICAgICBpZiB3b3Jkc1tpXT09Ii1vIjoKICAgICAgICAgIHJl
c3VsdD0iTGlua2luZyAlcy8lcyIgJSAoZGlyLHdvcmRzW2krMV0pCiAgICAgICAgICBicmVhawog
ICAgZWxpZiB3b3Jkc1swXT09ImFzIjoKICAgICAgcmVzdWx0PSJBc3NlbWJsaW5nICVzLyVzIiAl
IChkaXIsd29yZHNbLTFdKQogICAgZWxpZiB3b3Jkc1swXS5zdGFydHN3aXRoKCJtYWtlWyIpOgog
ICAgICBpZiB3b3Jkc1syXT09ImRpcmVjdG9yeSI6CiAgICAgICAgaWYgd29yZHNbMV09PSJFbnRl
cmluZyI6CiAgICAgICAgICBkaXI9d29yZHNbM11bMTotMV0KICAgICAgICAgIGlmIG5vZW50ZXI6
IGNvbnRpbnVlCiAgICAgICAgICByZXN1bHQ9IkVudGVyaW5nICVzIiAlIGRpcgogICAgICAgIGVs
c2U6IGNvbnRpbnVlICAjIExlYXZpbmcgZGlyZWN0b3J5IGlzIG5vdCBpbnRlcmVzdGluZy4KICAg
ICAgaWYgd29yZHNbMV09PSJOb3RoaW5nIjogY29udGludWUgIyBQb2ludGxlc3MgZXJyb3IgbWVz
c2FnZQogICAgZWxpZiB3b3Jkc1swXS5lbmRzd2l0aCgiL21rZGVwIik6CiAgICAgIHJlc3VsdD0i
RmluZGluZyBkZXBlbmRlbmNpZXMgaW4gJXMiICUgZGlyCiAgICBlbGlmIHdvcmRzWzBdPT0ibm0i
OgogICAgICByZXN1bHQ9IkV4dHJhY3Rpbmcgc3ltYm9scyB0byAlcyIgJSB3b3Jkc1stMV0KICAg
IGVsaWYgd29yZHNbMF0uc3RhcnRzd2l0aCgidG1wcGlnZ3k9Iik6CiAgICAgIHJlc3VsdD0iQ3Jl
YXRpbmcgY29tcHJlc3NlZCBrZXJuZWwgaW1hZ2UiCiAgICAgIHNodXR1cD0xCiAgICBlbGlmIHdv
cmRzWzBdPT0iYXIiOiAgIyBTbyBsaW5rZXIgZGVwZW5kZW5jaWVzIGRvbid0IGhhdmUgdG8gY2hh
bmdlCiAgICAgIHJlc3VsdD0iQ3JlYXRpbmcgZW1wdHkgb2JqZWN0ICVzIiAlIHdvcmRzWzJdCiAg
ICBlbGlmIHdvcmRzWzBdPT0ic2giIG9yIHdvcmRzWzBdPT0nLicgb3Igd29yZHNbMF0uZmluZCgi
LyIpIT0tMToKICAgICAgaWYgd29yZHNbMF09PSJzaCI6CiAgICAgICAgd2hpbGUgd29yZHNbMV0u
c3RhcnRzd2l0aCgiLSIpOiB3b3Jkc1sxOjJdPVtdCiAgICAgICAgd29yZHNbMDoxXT1bXQogICAg
ICBpZiB3b3Jkc1swXS5maW5kKCIvIikhPS0xOgogICAgICAgIHdoaWxlIHdvcmRzWzBdLnN0YXJ0
c3dpdGgoIi4vIik6IHdvcmRzWzBdPXdvcmRzWzBdWzI6XQogICAgICAgIHRlbXA9WyJSdW5uaW5n
ICVzLyVzIiAlIChkaXIsd29yZHNbMF0pXQogICAgICBlbHNlOiB0ZW1wPVsiUnVubmluZyAlcyIg
JSB3b3Jkc1swXV0KICAgICAgdGVtcC5leHRlbmQod29yZHNbMTpdKQogICAgICByZXN1bHQ9IiAi
LmpvaW4odGVtcCkKCiAgICAjIFRoYXQncyBhbGwgd2UgdW5kZXJzdGFuZC4gIE5vdyBkbyBzb21l
dGhpbmcgd2l0aCBpdC4KCiAgICBpZiBub3QgcmVzdWx0OgogICAgICBvdXRwdXQud3JpdGUoIlVu
a25vd24gbGluZTogJXNcbiIgJSBsaW5lKQogICAgZWxzZToKICAgICAgb3V0cHV0LndyaXRlKHJl
c3VsdCkKICAgICAgaWYgbm90IHNodXR1cDogb3V0cHV0LndyaXRlKCJcbiIpCgplbmRvZmxpbmU9
IlxyIgppZiBsZW4oc3lzLmFyZ3YpPjE6CiAgaWYgc3lzLmFyZ3ZbMV0uZmluZCgibiIpIT0tMTog
ZW5kb2ZsaW5lPSJcbiIKICBpZiBzeXMuYXJndlsxXS5maW5kKCJjIikhPS0xOiBzaG93Y291bnQ9
MQogIGVsc2U6IHNob3djb3VudD0wCiAgaWYgc3lzLmFyZ3ZbMV0uZmluZCgiZSIpIT0tMTogbm9l
bnRlcj0xCgptYW5nbGUoc3lzLnN0ZGluLCBzeXMuc3Rkb3V0KQpwcmludAoKCg==

--------------Boundary-00=_K6SVAZQXPCYEDFPFPDJ5--
