Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbTBNWEw>; Fri, 14 Feb 2003 17:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTBNWEw>; Fri, 14 Feb 2003 17:04:52 -0500
Received: from ns0.cobite.com ([208.222.80.10]:49414 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S267432AbTBNWEp>;
	Fri, 14 Feb 2003 17:04:45 -0500
Date: Fri, 14 Feb 2003 17:14:37 -0500 (EST)
From: lkml@dm.cobite.com
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.60-mm2+anticipatory results with Oracle db load
In-Reply-To: <20030131142213.37020b31.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301311740480.17695-101000@admin>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-556791216-321133549-1045260877=:24530"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---556791216-321133549-1045260877=:24530
Content-Type: TEXT/PLAIN; charset=US-ASCII


Andrew and list,

I've been tracking various kernels with my 'production load'.  The 
load and the platform are described below.  

As stated in the subject line, this is 2.5.60 + mm2 + all three 
anticipatory IO scheduler patches from experimental/

In case anyone is comparing these to prior results, be warned, I've
changed CPUs, changed Oracle tuning, and of course, changed kernels.  
Only the relevant kernels for comparison are included below (i.e. these 
runs are on the same HW platform with same Oracle config).

If you would like to see other tests, let me know.  

As per a prior request, I've attached 'vmstat 10' output during the run 
(and a bit after).  It's compressed.  If this vmstat is useless, let me 
know, I feel a bit bad spamming the list with it.

If you'd like other profiling, let me know along with some hints on how to
use it. I tend to think this is really an I/O scheduler + user space CPU
utilization issue (not a kernel system time issue).


kernel                        minutes
----------------------------- -----------
2.5.59                        102
2.5.59-mm8                    105
2.5.60-mm2-with-anticipatory  107  <- attached vmstat.log.gz for this


Platform and configuration:
HP LH3000 U3.  Dual 1Ghz Intel Pentium III, 2GB ram.  megaraid controller
with two channels, each channel raid 5 (hardware raid) PV on 6 15k scsi
disks, one megaraid LV per PV.

Two plain disks w/pairs of partitions in raid 1 for OS (redhat 7.3), a
second pair of partitions (regular partitions with ext2) for Oracle
redo-log (in a log 'group').

Oracle version 8.1.7.4 (no aio support in this release) is accessing
datafiles on the two megaraid devices via /dev/raw stacked on top of
device-mapper (lvm2).

Workload:
The workload consists of a few different phases.
1) Indexing: multiple indexes built against a 9 million row table.  This
is mostly about sequential scans of a single table, with bursts of write
activity.  50 minutes or so.

2) Analyzing: The database scans tables and
builds statistics.  Most of the time is spent analyzing the 9 million row
table.  This is a completely cpu bound step on our underpowered system.
30 minutes.

3) Summarization: the large table is aggregated in about 100
different ways.  Records are generated for each different summarization.
This is mixed read-write load.  50 minutes or so.

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


---556791216-321133549-1045260877=:24530
Content-Type: APPLICATION/x-gzip; name="vmstat.log.gz"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="vmstat.log.gz"

H4sICCFpTT4AA3Ztc3RhdC5sb2cA3X1Zki25jeW/VnGXwHlYTkklWetDLZnU
srLafRMHIJ3uDtL9ZmWbvej8iIwXwwmAADGT/Hw+//jn3//0r4/639/+/Le/
//O/+fN//dd//OP4zl//zl/873/9nz//jb/0p3/8+w+ff34+f/x8/gs//4//
bP/7yz///Of2vz/++y9/aT/yH3/6X/Svf/2VPgDij3/FR/r8r/8bMP/6/Ptf
Dfjz1//8w8d+PubzcfwHzMcGX4qnf9YQyifm9q/E3+ofUqCPNn4+MeL3SsV3
zKfWO551Nhb6jRrbL5YaTQgTnrfJWaC6j/UxE3KKH9d+pn5S/gP9nJ3wSqkh
EkE1tT/e0FM40edtMIU+zYbwEii1H9eoLZ9UbvQ1PF/Bbg5Gw3OF+fW54SUL
vEZf+xtxhUff/NTS/qfj4d/tqw3PAC9NeO7Cb3DF0E/VhtvwfIlxxnPVRFoi
11bV8l+2pf0ZA7wA+k54zpdAv2BIDtaGWHm9unydz/TtYGv7GZLsx7n8icAI
Cr+2VBKvNRbrF01yJzwSLYmD1s9AsZpmAc98wl1fCM/SGhiH9bviuWQhLqyf
A330h71vX/kkr+EVWrD2t21S8LzzrI+J9AWitk1AjWWRx1X/bMkEYE0wQcVz
edDnm6a0H812kq+50pdzBL+hknyjjaf90f5AhRJb+msZ8nVNEqAp5ju/jYcA
+pJlvMT0TPJo/3bJB/qb+FNt14VE34xBw/PMbyrg1xabNDzjaI1p/zY1aZIF
ntHwLOPlCHnYGlX6IvCwtNF0PKvhGQN95v0WHa/XHS8MvAa2oS/mAH2uDvrs
bJ7x2tdtITxHqwt78GmCCw7ySHd98TEU4hfKT3j+tN/aRqO1t74e8jV+ku8d
z9EustYKv/5MX1NL2vIeuxvfalt9S59NoM/x/nDhZF+sbxaV+M303cJ4W/2L
Ta0Iz/P+cDGYE30pgd9M1BcHvDTh/ShvWXxga2U9716Xymn3NjZpMbwnXcoe
3Ibd6oXsSEJt2/Pq5XRaPZ8qpJEgDXhLazba4rLJoK/tEsIr+Uxf0+4G4kI6
pFvtx1eypvFu/TJ5N9CXoQ81+rM1cCZQXFDImztyQp/cfoDMQrP59Y4XQzLQ
vlLJnrsWdJgTHnZHpJDAOtKr5tPqhzZAs/bxDwJ24DkTE9yho93bdulZHg2P
/lxsuwd/jfBS7t4j3Ohrv80CbF6T8GrOF/qaIW14tAfbz5A1SGX2Rle8JtbC
7pr0hfZWKBd+iT6TiT7jO78WeLx7/YxnW3hB8nWw9s3253Kmz5BQo6G97Qzo
a67twLvoXyzRgD5v2jo1pY7ibQ88Mt6hAA9L0Via1u+K17wX9oeHtWqxTDlb
e2c96Kvgl1QpNRu95JdsFay9d4HwUlvzC31kQkOthfBAn+VoyCOavNAXSvtR
0If9G6o/e9+GB93NlaRvoC+NSof9oUQHof16wobPtH+bcfZnfWFvFxKiF2yd
RPtjSZ/LFd7SF0d4jcCzvlgi5+NLhS8g+kixiGbXkDU89m6exKLg0VZsP59p
fxgmnbwlkaB534ZXWF9oGVU8iTbK4X0jOfTD+0LWV7wWxKv8flgfyKg0+mB6
Qj7jXemjVaZwdkdfJm2C40T0ssPjaI2icg2vRNJnl2r8wEG3/5pCYsnbZtDw
EqKDliQUBa+Zh1pBfiabS/JticVP8pbuzK1hadAmIW7zybq0eJm8G2xij108
+SHkHpo0ErZrS2IoWoxk5k6r11IdLG6q5GGM4GXQ5O7Wj/A86EuQxh2vQro5
El4F3s6bNzwkozYg1tXwqjmkGyHdusXzzG+h6I7wTrF906KGRG6gHLFk+zVg
KN684Tnebcgt73i+BW/EL+XSHG2c6bvgNTME80ZJEa0fpapnaxoolowRvp69
eZPHMncjY4xctQXhjb5EzufizTPhNWdK1hTeMvpzdHDCc46jgwjvm2LTtKu1
N2QAKDdyDnh+4z1a7m2gYBHRcSreXbxlo5joY2sP79Ec+zLaaMEKe7dIXtxm
05zSmT5HJj46eDdrnvh1LZehXdQcA0V/mVK5C7+NnMZvQSwH+tzM75U+07w3
nA68b26hhLl4N8q9msnC+rE3D02MFP2RN1LwkCskKoQoeC0ioDycYrZGH+E1
Tib6woXf5jQgD6TAOl4gfinasGR3W0ZUuze/R6cND8mVhVlgvMv6VY7WKPav
5D3aggPPabWhhmd5/WAPgHf25rRypH+x6zOVzpbRRhMfRy+pWhWv/QDWz5YR
TbYYUKIrRZ9NTli/pnmCd46u2vJHsgeo5SB3o5iSIn6r1Q4oGMP+zZCggofa
kEM01KMDu87NJ7yq08fRQaLso0cHc7Txy3tLnVuXVqtH3MaS9MrLXVvYGmQf
tdWz0JOmg8hVxbvlyXsstSWo9LXQlJx9s/O+W3sqYi29UcNDJbbhkXVW8Hjz
eNodbA2s2XjLAy9S7Kzwi91suS5YeyXCY/cqueqEF3S8iEpsycNaveSXNrnG
b4U3r8g8LSrP7Qtb+hC9ZKpIMt6pktOSRLIkppRurSijOXKFO56Ft8xp6Msl
16fgoTHtCY92byL63JS7nfFSZn6RGxGeO1tnS9FG9Ie+JBcn72bO0SThsT6X
bq1u3o2ssyN+nWM8v859HVU4wW/Jon/nSrZDwhYpIh/0uXOueqUPtYOWPAYV
z9Jejd7WsX4m7qz9wCsiX3+yB7aSyQsl2p6rwhsVwsuaNRW8Yro++4t8fYD3
cD03jyVP9N3xUDq0xRqj49HvhorolBxdo2/r3RLvj2K9yONaeyEXHmB9Dn69
WXrfFDPT16ONc/TXknaPVDuiuvpBvLXO3Rpeclg/2+VxxvtQy4lywXzklnWd
WxIecsFiu/274SGXpuile8tN7jvjpTVeMFTJNlyWiXaqtP8wb4kgsnHrFtJF
wOIy+goRq5e4D2W1PhRpM68eVXDueC11iPAeqJwi19rmRgdesJo0qA+A1A51
2jJyt2c8CsmXeFT/7db+XGdX+GVtTkbT5k6fT7nn5lMlQt29rmK3JVX7On0J
lSvpK/gtfahHWVSwVbyKQhm6Npzr7/oUzsTK1qAMeZxz81S50gT6EL2ccv0b
vwFt84bX9e/UR/lkpDrBkDVgfn1TRQ/rnLRoLSAcaIFYxzv38ZrFi8jdRqU9
tYzhlKuevVFIyC2r7fqcz9YZCWWktMMibf1QSXmTCwbWv+q6d7viRVTaQxyV
XRu3ePDRDS8J3qWS7al83UK54d1ocODqff2Ex5Xs6rv+XSvZyH1rzBQdsPct
O+/W8ULU8RAsNe9mujePpU654J1froXVaMXan/uWzmbgcXQaJryFtwzorje8
wvItl9yXgsemLzn2aBe5Zem5741fj9aT5TkGBY9zadTCuJIda9nl0p5z/VqF
33LJpS0Nf4SKWg7+FCWbG31hvPajptN3yX2poNE2UT6iDbeTr4c+N7yxfhc8
RFfZYP2oVke1pEO+v7a3vK+ecGsl9rtw+/FkmZpcPXlLWL+mBjIlcK/UkTRg
zk2PNa542Jo+W0wdIFeNft3VP/Dcgj7Jff2U+9YtXuBk1DtVuoJH5S9LCSvR
F3axlUcfr/0/aXg0VoNKLKY23nijTl8Yu+OEhyyG8OLo+5I3N8vcfOCp8mh4
DvR5WBfuS8c3eNHqeBWVIdqybfdyXzr0XFXFI+9HRmSBZxMZs+aU0Rt+5tfB
+7Y/bVR5tEgdsX08ahGOow2vTUUQHss3F826NB9KtRIwIZVYTCGtc3OuPDej
JLlquebSpGstFzToXX8oON1WYh0q4zTsIvRdcukGeOSq8L4unb3lBY/l0bRA
6Lvk0jB5DQ+5Frylq7tc2qGz4NAk1vBgTSNmTnj9aMNs+OXGaYtOcqfvkktT
wSpSQkYDh1g/u+4jE57Dr4VO3zmX7rUDRPdc2a2zt1ToE7xO3yX3tRxduSO6
auEM7UHOzc01WrOYWnNUytbwpI9cE/CirN+OPsHLnd/rnAU6Fd6N/dvC7V20
YRH+OFv6frt2UgrNRVjMaEo0NNcOfm1vedNmi8qBo2RL4/bj2JlSLMSZNKxL
WXojS0kRlFZdvQ9rw6myG3febeB1bXmDd3i3u3QZz43YSsPzJg9+HyobLY5w
wAsqXkRbs21ui/k6+moLLjEXp0cbHc+q60e5peveqHvLbW5JnWLgdet3wcsY
kUMlwJYxxYUdGzXrN/Cqpi82wNhKdCC5dD7TZ0+5TMdzTpPvyKVRiRVvOSrP
O35d1vnt9E19ZLurZHc87zT5NtdIfcsWbYRj5q+8wiu6fFEKaIniMQVnwi46
MBjibqvXo7Xz1Ib3mGZHdMV9stgM/7pPSzkCnGwa/F77bmRNSVV6H3nvLQ1K
ww7TasCLF++BXBqxK1t7GvvZeHOD1oZDBRZ4pylC2ojAK+XIpf2ucj/wejR5
6euzdwuoDVXO9fOmL02z58SvN90bnfGax6C+JerS7M1bfLnlF/Va563UIkq6
yCOiL53j8Jal5ZZhMXcw4UknoFxrLzxllo/c/Kg8a9FLx+u1khse95GL7523
WOZazq/tLe/cojTgvO/W6lzJsRhpC5krQ1W43WTmPGXR8Lq1KhdtoVwhSN8N
qxfTVIm44NlacWLB+ZA6fecufCFtDpFiIRRhaOwQ1sBp2tzwOFfwUccTGWNv
99wyUemevKVT6UvgN5kVHvoApo4J/vZx2TWf8Lr3veEh96W92KOD/AqvW2ed
Pp756134LR6si886v4VGdIk+N2bqij33ZWZvOeF163fCG5VsTPDL1NWmkk1D
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
6ufdDK4aa3gcOwdzrUyOwbJ3UwcGuTl1o+CN+gT2sTsYP+RZ+3Z4iaMDmRoK
7np+CZelftCn4Ltoklm/V9jw+EClkbtZgr+cB/U80U9vmhjc3UEHOpd3DU14
QfCut0bH7iKHt9xaUyOxc+JoI8SLPDxMlHXk3fAtkvLyLilbamZrL7cnxIu+
tFSMD5USv3QBPB3R6HjKCZKWsrE8Mvf1oz+fmPEx4pgC+tJ8b6/Pm/UrfDrc
GzmPRy/KnvcHxvYzbhnH06ihoeK2PvX2hMLnS72R3DyZy4kjPmHAd0lJIHip
vZymQAoa3ITH+pLs5WY5w488ztZ5N3Na+Hxpw2Nrn9zlbpvEVybkOGovcbc/
Jryk4ll5vzQo3lfFk+j+AY+svXHPU1ev8RynDE/7o1lntn8l6nhS0IA94GiN
ovtl7a/hsT5LZyu5s77IZczCL3vzXefooK8mFa8XXGh/uLs9/VnecnArd4ss
uZ2kuzsBMaQhJwLu0ghT34gFs9XmXDg2rbLb0tnaY3aUYD1e4frQRWsFLxJZ
7b3Chpc49qtRxfOJRyGSH7d4ywmXhfXLib2vnN+84o3Yrxy55dYaDLyi4zk+
nYxKnezerTwEDyG+hudjT2CGd9vF4geeWIMrnswQ4sTMi8r4gRd1vE6fMmWm
4+G8YMPLgnfx5oGbx2mqxO4qfyXjPKO3UrlS8JjflzOxE96KPuBle+jL5s0f
GnnF/rVyM1q63gZi5GmA0PvmFCisb2NoeEyfzDimy+l1uV6NsvHeV627XLDh
4ai8taIvV7xcj1yLX1+3m9egbYnRMh7rS76cH/aWtw+iZ8wU07Awjr7p/MbI
+iJ96QsevZOKT3EXDfNL0YsjDOWVAOCxPHj/XvFckBMkYZjCRmrAeVrt9o6G
h2jISm0t18v5XHN0yizf3lE4d3vC42j8imflZkLKpS3rX3HrN1ImvJq2eLHn
luD3h+SWd+nifi1vpVJ349bwXTJk7S1XIopbv5824Vl19YzcIk2xqeXYNNe+
elu8oNJn5O4cSIOt1SFdHS/DOsv5IIU+5tce/MZX/OraN+hLr+kTvKLLw3GC
it3G1n6Px69BeyuVMLzEpMgXb4Hz7qgW1sXpuVYAQ56ef1XxJBdh+nj97G63
Dbyo42W5nJjWL/JNa2aPJ/ymouC138YVBzzz556nGOi5R1i/MOSh3F0klWI5
2H3xvu6CV8wez2F7kO7wQXuiD2QF5TaQYpFseCszsSWd77YplvyuTQmn14m1
QO95knSwfnc8VJAantPwvI98IoxqJR43TdJ9hHQUIqq1oQOPK8U3PMnViSKP
XJoIPvDW9HH0csVzWR5KwtviqB2k+AZP5iJu9AWWD8m302c2eAFFK8Jj+1fy
ubYRcVsE37PLryMHqZz6KRf0E57l6EDmIsrl7rGIYAlPUDeVJ3tAV8YGnIfX
9m8wEr3Ivb1XvCryhbdkU5jdplYXDNderMzYXvBsf3OGow32lmmKDn5tb7nm
1mvSsC4e2mz5/Ff7wjoWCoYrEf2O+xuexFYR1s91vKX1O/DSFg/eUmI11ytX
ijXwtQoe5x43PM+5MN7HE+kWaJ9TvdHAK4v1s0cXvsemc2y1pK+ou2PEkiyP
Eb0s1+/AW6yf4RllXj97w1vTt1g/e5wH7fT5V/SJNV3wi76HyHenLw0PlV0r
7z2u8BD9cV+wxB6L6/IVvKDiBc8hC6wBQ1e/uXf2wEsav+Mj3dVknBXRrKeu
Djzd+vWPbvLmYY/H1rmKN7rcnRUdQqqAynhmfa6oZFvVOh/01aTgUeng2L98
EyHh+b5+d/3DjLzvryLc8CQXzHXgUe7L+1epDTU89N2cTPnc8KwJB32sL7O1
V+gTPK/z23PVcMpVl/b0wIs6ntCHmzpTOq/fFi/p/PJ1hkzfkau+wFP15Vg/
4Jkb3s/ylr7C3fj+5kU53wRH3OLfFKt1bclTpn/XFrywRXhBxRNtYW958b7q
7uh4TscTacCaRramZS9dVGKdDTq/XVuwO/xZ+1Tr1/GShvepiVUO2sK5Qt7l
ql76bs5273HG6x8d5Ua2Q69zo7F+jmPdas4v/ni5fDUdtyfEy+uvp77Wgcex
5AWPZgL7IVq5t5di4/W9mhNeUPGk2Uury7dat2V8hcfRyxWvyItRPh2vX5v1
i2ITXlDpK9L3Bh7f67p73XzCyzp9eLPhjLd5oazh4aZJ77xR5VFEHrH0Iur2
dfMJb7F+xnJCnse9qS/piyperkctovO7eTFuwsuqPlcpX+OFKM6N0q4P76tn
ecibMNWcK7vy0WMqzPY06cj1NfpgT+XER98Pnd/m6+1HXglwPPXiWV+8eg8w
zX0AT6aGLnj09BHWD/dG41stnYM++8X+gMFseKLPV7x45IIOgSCV5PFqo/ae
7Iy3pQ94qK11PH6f9qd5y85t1KR75lYGLmZu13hiDa54Hlepw1s6VGKtrevX
fQkPfQAn7ymupIvdi64+udVDujf6Smb64kK6hr0T3TPp+ArQpjPH+4d3PI7F
F3g0PoPdm46ZSb/rmh947H2rO92i3EJg5IIWLzCJ9mXhV3lPccYrCh55AdPl
6xEd0N3gZMGi+obBgVdUPBvZpNBq+FA7Xn3Ek9e0b3iJrbMHXp9qIrywwMML
Ub6/OHXHizxlVolfI/SRYkftxSTCQ1/LyfuC1V9ev+aCC2bkOFqDtV9HawWl
Ke/kbqULnperseGbPT28TE9DTutn7/QJXlHxXI9eIN9RSSx9/Zb0yV1NN/qy
5IKTPOIkDwWP5ZG5E3DD6/JNB17Yyjd2vLSjL5lDvqWvn7p/uQ868MK575sy
l1/9uAcYL7zl7n0ZzCv0SfR3xrOJH+/O3hy3yG+jqwe8MM2B2My3+m9e8Jvw
JBq64vGLdplf0cBXT2/WKPIQfRH7d8HDrQ+fHv3BHlgz2atf21veuQ15yy20
z8od9yM2qMtYaOAlFa/KGHaM/UWYY/V078Z9ACeVU0UarH1H7EIv4JQeW7lv
8fJRGZLXfU2dpPstfTHLVdaxv4/3EDsXqTTJGy41aJU1m3GLt3K3yF0eEpsu
8CIStgpfGvF8Q5SJdqog/IHsgFHxZAazhnPui3d42wajEwaJ1s8m6pO1sKgs
di/3aQdePL+27BKaY5jZ5coaFTs2uWVxrH9FrN8Fj9uGjSh/vDhlt/LoeOJ9
r3jyrBZqERJobSuxhfuMTmYmr3gJT9qwvvCt+VPupq4fn9BwMjN5xevWqoT+
pgRexNpEf0b4Tao8eq7Pubnv+2PIQ9G/LV5zVtBnfhGL7UGYcqM1Xtb57bUD
7F/gmbLdv5b3r9xWcsGjAu2IJvlVBLxpMuzLBk/Tl7bmFfYAcxtcZqMpwjxV
sq/8snyr0+jDBqHYBZ0jlInopEEETdqJKJ95JttJZ+GKlzLO3kTK9VMCqW2h
SR5Vr7TnzNHGwDvPtH/wiEDL4EfnIxg+r9/oS7+6t7xzmzDF4OQFq5pvryOT
TIIZN2fR40nr82k+szXwMoNZL29zB7xm4nFewOPoG81aUFBO9QMNj2cIvdxF
c8ET63e2VpFmOMj7KjN1jT5oizcSq13wZKqEZ8zCXHleVE6f8MKRu1meaKcT
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
3MXlBeBqPOz/AvQ9XMsyEwEA
---556791216-321133549-1045260877=:24530--
